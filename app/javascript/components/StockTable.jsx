
import React from 'react';
import { Card, DataTable,AppProvider,Page, Button} from '@shopify/polaris';
import ModalContainer from './containers/ModalContainer';
import SaveContainer from './containers/SaveContainer';
class StockTable extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      sortedRows: null,
      activeModal: false,
      updateModal: false,
      rowList:[],
      title: '',
      record:{
          id: 0,
          email: "",
          contact: "",
          product:'',
          shop_id: 0,
          variant_id: 0,
          active: false
        }
    };
    //this.toggleModal=this.toggleModal.bind(this);
  }
    componentDidMount(){
      let record={...this.state.record};
      record.shop_id = this.props.shop_id;  
      this.setState({record}); //updating value
    }
    
      sortCurrency = (rows, index, direction) => {
        return [...rows].sort((rowA, rowB) => {
          const amountA = parseFloat(rowA[index].substring(1));
          const amountB = parseFloat(rowB[index].substring(1));
          
          return direction === 'descending' ? amountB - amountA : amountA - amountB;
        });
      };
      toggleModal=(i)=>{
        if(i==1){
          this.setState(({activeModal}) => ({activeModal: !activeModal}));
        }
        else if(i==2||i==3){
          let record={...this.state.record};
          if(i==2)
          {            
            record.email='';
            record.contact='';
            record.variant_id='';
            record.id=0;
            record.product='';
            this.setState({title:'Add', record:record});
          }
          else if(i==3)
          this.setState({title:'Update'});
          this.setState(({updateModal}) => ({updateModal: !updateModal}));
        }
        else
        {
          this.setState({updateModal:false,activeModal: false});
        }
      }
      inputFormData=(data)=>{
          console.log(data);
          this.toggleModal(1);
          this.setState(({record}) => ({record: data}));
        }

      deleteRecord=()=>{
        const id  =this.state.record.id;
         fetch(this.props.url + '?id=' + id, {
          method: 'GET'
        }).then(response =>
          response.json().then(json => {
            this.toggleModal();
            this.setState({rowList: json.list});
          })
        );
      }
      editForm=(element)=>{
        this.setState({record:element});
        this.toggleModal(3);
      }

      saveRecord=(data)=>{
      const item={contact: data.contact, email:data.email, active: data.active,product:data.product,variant_id:data.variant_id, shop_id: data.shop_id,id: data.id};
       
         fetch(`/stock-app/update?id=${data.id}`, { //+data.id==0?'':`?id=${data.id}`
          method: 'POST',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({account:item})
        }).then(response =>
          response.json().then(json => {
            this.toggleModal();
            this.setState({rowList: json.list});
          })
        );
      }
          
      handleSort = (rows) => (index, direction) => {
        this.setState({sortedRows: this.sortCurrency(rows, index, direction)});
      };
     
    render() {
       const {activeModal,record,rowList,updateModal,title}=this.state;
       const {rowData}=this.props;
       const rowTable=rowList.length>0?rowList:rowData;
       let rowArray=[];
        (rowTable).forEach(element => {
          element.action=<div><Button onClick={this.inputFormData.bind(this,element)}><i class="fa fa-trash" aria-hidden="true"></i></Button><br/><Button onClick={()=>this.editForm(element)}><i class="fa fa-pencil-square-o" aria-hidden="true"></i></Button></div>;
        });
        (rowTable).forEach((element,i) => {
          rowArray.push([i+1,element.product,element.variant_id,element.email,element.contact,element.action]);
        });

     // const rows = [rowData];
  
      return (
        <AppProvider>
            <Page title="Sales by product">
              <Card>
                <Card.Section>
                <Button primary onClick={()=>this.toggleModal(2)}>Add</Button>
                {/* <Button primary onClick={()=>this.toggleModal(3)}>Edit</Button> */}
                </Card.Section>
                <Card.Section>
                    <DataTable
                        columnContentTypes={[
                                'numeric',
                                'text',
                                'numeric',
                                'text',
                                'numeric',
                                'text'
                            ]}
                            headings={[
                              'Id',
                              'Product Name',	
                              'Variant Id',	
                              'Email',
                              'Contact Number',	
                              'Action'
                          ]}
                            rows={rowArray}             
                    />
                </Card.Section>
              </Card>
             
              <ModalContainer active={activeModal} deleteRecord={this.deleteRecord} toggleModal={()=>this.toggleModal()} record={record} />
              <SaveContainer active={updateModal} title={title} saveRecord={this.saveRecord} toggleModal={()=>this.toggleModal()} record={record} />
            </Page>
        </AppProvider>
      );
    }
  }
  export default StockTable;


