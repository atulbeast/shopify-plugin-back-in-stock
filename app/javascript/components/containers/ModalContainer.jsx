
import React from 'react';
import { Button, Modal,Stack,TextField,TextContainer} from '@shopify/polaris';
class ModalContainer extends React.Component {
   
    node = null;
  
    render() {
      const {active,record} = this.props;
  debugger
      return (
        <div style={{height: '500px'}}>
         <Modal
            open={active}
            onClose={this.toggleModal}
            title="Are you sure?"
            primaryAction={{
              content: 'Close',
              onAction: this.toggleModal,
            }}
            secondaryActions={{
              content: 'Delete',
              onAction: this.props.deleteRecord
            }}
          >
            <Modal.Section>
              <Stack>
                <Stack.Item>
                  <TextContainer>
                   <p> <label>Email: </label> {record.email} </p>
                   <p> <label>Contact: </label> {record.contact} </p>
                   <p> <label>Product Name </label>: {record.product} </p>
                   <p> <label>Variant ID </label>: {record.variant_id} </p>
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
  export default ModalContainer;