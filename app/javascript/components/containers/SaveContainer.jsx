
import React from 'react';
import { Button, Modal,Stack,FormLayout,TextField,Checkbox,TextContainer} from '@shopify/polaris';
class SaveContainer extends React.Component {
   
    node = null;
    constructor(props){
        super(props);
        this.updateForm=this.updateForm.bind(this);
    }
    state={
        form:{
        id: 0,
        email: "",
        contact: "",
        shop_id: 0,
        variant_id: 0,
        is_active: false
        }
    }
    updateForm=(value,name)=>{
        //const target = event.target;
        let formData = Object.assign({}, this.state.form);    //creating copy of form state object
        // const value = target.type === 'checkbox' ? target.checked : target.value;
        // const name = target.name;
        formData[name] = value; //updating value
        this.setState({form:formData});
    }
    // updateRecord=()=>{
    //     debugger
    //     this.props.sendData(this.state.form);
    // }
    componentWillReceiveProps(nextProps){
        debugger
        let formData=Object.assign({}, this.state.form);
        formData=nextProps.record;
        this.setState({form:formData});
    }
    render() {
      const {active,title} = this.props;
        const {form}=this.state;
      return (
        <div style={{height: '500px'}}>
         <Modal
            open={active}
            onClose={this.toggleModal}
            title={title}
            primaryAction={{
              content: 'Close',
              onAction: this.toggleModal,
            }}
            secondaryActions={{
              content: 'Save',
              onAction: this.saveForm
            }}
          >
            <Modal.Section>
              <Stack>
                <Stack.Item>
                  <TextContainer>
                  <FormLayout>
                    <TextField label="Product Name"  value={form.product} onChange={(e)=>this.updateForm(e,"product")} />
                    <TextField label="Variant Id" type="number" name="variant_id" value={form.variant_id} onChange={(e)=>this.updateForm(e,"variant_id")} />
                    <TextField label="Contact" name="contact"  value={form.contact} onChange={(e)=>this.updateForm(e,"contact")} />
                    <TextField type="email" label="Account Email" name="email" value={form.email} onChange={(e)=>this.updateForm(e,"email")} />
                    <input type="hidden" name="shop_id" value={form.shop_id} />
                    <Checkbox checked={form.is_active} label="Active"  onChange={(e)=>this.updateForm(e,"is_active")}/>
                  </FormLayout>
                  </TextContainer>
                </Stack.Item>
              </Stack>
            </Modal.Section>
          </Modal>
        </div>
      );
    }
  
    handleClick = () => {
      if (this.node == null) {
        return;
      }
      this.node.input.focus();
    };
    saveForm=()=>{
      var self=this;
      console.log(self.state);
      debugger
      this.props.saveRecord(this.state.form);
    }
    
    handleFocus = () => {
      if (this.node == null) {
        return;
      }
      this.node.input.select();
      document.execCommand('copy');
    };
  
    toggleModal = () => {
      this.props.toggleModal();
    };
  
    bindNode = (node) => {
      if (node == null) {
        return;
      }
      this.node = node;
    };
  }
  export default SaveContainer;