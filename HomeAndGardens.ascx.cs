// Copyright (c) 2012 Cowrie

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.UI.WebControls;
using SelectedHotelsModel;
using TreeNode = DotNetNuke.UI.WebControls.TreeNode;

namespace Cowrie.Modules.HomeAndGardens
{
    public partial class HomeAndGardens : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    using (SelectedHotelsEntities db = new SelectedHotelsEntities())
                    {
                        BindSizes(db);
                        BindData(db);
                    }
                }
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }
        }

        private void BindSizes(SelectedHotelsEntities db)
        {
            IList<HomeAndGarden> homeAndGardens = (from p in db.Products
                                                   where !p.IsDeleted
                                                   select p).OfType<HomeAndGarden>().ToList();
            var query = (from h in homeAndGardens
                         where h.Size != String.Empty
                         orderby h.Size
                         select h.Size).Distinct();
            CheckBoxListSizes.DataSource = query.ToList();
            CheckBoxListSizes.DataBind();
        }

        private void BindData(SelectedHotelsEntities db)
        {
            IList<HomeAndGarden> homeAndGardens = (from p in db.Products
                                                   where !p.IsDeleted
                                                   select p).OfType<HomeAndGarden>().ToList();
            List<string> selectedSizes = new List<string>();
            IEnumerable<HomeAndGarden> query;
            if (CheckBoxListSizes.Items[0].Selected)
            {
                query = from h in homeAndGardens
                        select h;
            }
            else
            {
                foreach (ListItem item in CheckBoxListSizes.Items)
                {
                    if (item.Selected)
                    {
                        selectedSizes.Add(item.Value);
                    }
                }
                query = from h in homeAndGardens
                        where selectedSizes.Any(s => s == h.Size)
                        select h;
            }
            if (DropDownListSortCriterias.SelectedValue == "Name")
            {
                ListViewContent.DataSource = query.OrderBy(h => h.Name).ToList();
            }
            else
            {
                ListViewContent.DataSource = query.OrderBy(h => h.UnitCost).ToList();
            }
            ListViewContent.DataBind();

            LabelCount.Text = query.Count().ToString();
        }

        #region IActionable Members

        #endregion

        protected void DataListContent_DataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
                e.Item.ItemType == ListItemType.AlternatingItem)
            {
            }
        }

        protected void DropDownListSortCriterias_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SelectedHotelsEntities db = new SelectedHotelsEntities())
            {
                BindData(db);
            }
        }

        protected void DropDownListPageSizes_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataPagerContent.PageSize = Convert.ToInt32(DropDownListPageSizes.SelectedValue);
        }

        protected void ListViewContent_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //set current page startindex, max rows and rebind to false
            DataPagerContent.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            //rebind List View
            using (SelectedHotelsEntities db = new SelectedHotelsEntities())
            {
                BindData(db);
            }
        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            using (SelectedHotelsEntities db = new SelectedHotelsEntities())
            {
                BindData(db);
            }
        }
    }
}