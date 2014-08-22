<%@ control language="C#" autoeventwireup="true" codebehind="HomeAndGardens.ascx.cs"
    inherits="Cowrie.Modules.ProductList.HomeAndGardens" %>
<%@ Import Namespace="Common" %>
<%@ Register assembly="DotNetNuke.WebControls" namespace="DotNetNuke.UI.WebControls" tagPrefix="dnn" %>
<div class="categories">
    <h3>Sizes</h3>
    <asp:Button ID="ButtonSearch1" runat="server" Text="Search" OnClick="ButtonSearch_Click" />
    <asp:CheckBoxList ID="CheckBoxListSizes" runat="server" AppendDataBoundItems="True">
        <asp:ListItem Value="" Text="All" Selected="True"></asp:ListItem>
    </asp:CheckBoxList>
    <asp:Button ID="ButtonSearch2" runat="server" Text="Search" OnClick="ButtonSearch_Click" />
</div>
<div class="products">
    <h1><asp:Label ID="LabelLocation" runat="server" /></h1>
    <table style="width: 100%">
        <tr>
            <td>
                <asp:Label ID="LabelCount" runat="server" /> items found
            </td>
            <td>
                Sort by <asp:DropDownList ID="DropDownListSortCriterias" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListSortCriterias_SelectedIndexChanged">
                    <asp:ListItem Selected="True">Name</asp:ListItem>
                    <asp:ListItem>Price</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                View <asp:DropDownList ID="DropDownListPageSizes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListPageSizes_SelectedIndexChanged">
                    <asp:ListItem Selected="True">10</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:DataPager ID="DataPagerContent" runat="server" PagedControlID="ListViewContent">
                    <Fields>
                        <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </td>
        </tr>
    </table>
    <asp:ListView ID="ListViewContent" runat="server" OnPagePropertiesChanging="ListViewContent_PagePropertiesChanging">
        <LayoutTemplate>
            <h3>Product Listing</h3>
            <div style="width: 100%">
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>                        
            </div>
        </LayoutTemplate>
        
        <ItemTemplate>
            <div style="margin: 5px; float: left; width: 210px; border-top-style: dotted; border-top-width: 1px; border-top-color: #C0C0C0; min-height: 280px">
                <table>
                    <tr>
                        <td style="vertical-align: middle">
                            <asp:HyperLink ID="HyperLinkName" runat="server" Text='<%# Eval("Name") %>' NavigateUrl='<%# DotNetNuke.Common.Globals.NavigateURL(TabId, "HomeAndGardensDetails", "mid=" + ModuleId, "Id=" + Eval("Id")) %>' />
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle">
                            <asp:Label ID="LabelPrice" runat="server" Text='<%# Eval("UnitCost", "{0:c}") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HyperLink ID="HyperLinkImage" runat="server" ImageUrl='<%# Eval("Image") %>' NavigateUrl='<%# DotNetNuke.Common.Globals.NavigateURL(TabId, "HomeAndGardensDetails", "mid=" + ModuleId, "Id=" + Eval("Id")) %>' ImageWidth="100" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Literal ID="LiteralDescription" runat="server" Text='<%# Eval("Description") != null ? Server.HtmlDecode(Eval("Description").ToString().TruncateAtWord(120)) : String.Empty %>'></asp:Literal>
                        </td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:ListView>
</div>
