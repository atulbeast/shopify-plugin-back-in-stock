
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
      record:{}
    };
    //this.toggleModal=this.toggleModal.bind(this);
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
          this.setState({title:i==2?'Add':'Update'});
          this.setState(({updateModal}) => ({updateModal: !updateModal}));
        }
        else
        {
          this.setState(({updateModal}) => ({updateModal: false}));
          this.setState(({activeModal}) => ({activeModal: false}));
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
        debugger
        // const id  =this.state.record.id;
        //  fetch(this.props.url + '?id=' + id, {
        //   method: 'POST'
        // }).then(response =>
        //   response.json().then(json => {
        //     this.toggleModal();
        //     this.setState({rowList: json.list});
        //   })
        // );
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
          element.action=<div><Button onClick={this.inputFormData.bind(this,element)}>Delete</Button><br/><Button onClick={()=>this.editForm(element)}>Edit</Button></div>;
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
              <ModalContainer active={activeModal} deleteRecord={this.deleteRecord.bind(this)} toggleModal={()=>this.toggleModal()} record={record} />
              <SaveContainer active={updateModal} title={title} saveRecord={this.saveRecord.bind(this)} toggleModal={()=>this.toggleModal()} record={record} />
            </Page>
        </AppProvider>
      );
    }
  }
  export default StockTable;


