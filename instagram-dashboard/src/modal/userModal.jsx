import { Button, Modal } from 'antd';

const UserModalComponent = ({modalOpen,setModalOpen,sendstatus}) => {
  return (
    <>
     
      
      <Modal
        title="Edit or Delete"
        centered
        open={modalOpen}
        onOk={() => setModalOpen(false)}
        onCancel={() => setModalOpen(false)}
        footer={[
            <Button
            key="submit"
            type='dashed'
              onClick={sendstatus}
             
            >ok</Button>
        ]}
      >
        <div className='flex flex-col items-center gap-4'>
        <Button
            key="sbmit"
            
           className='bg-red-600 text-white'
           
            >Delete User</Button>
              <Button
            key="ubmit"
            type='primary'
            className='bg-blue-500 '
             
            >Edit User</Button>
        </div>
        
        
      </Modal>
    </>
  );
};
export default UserModalComponent;