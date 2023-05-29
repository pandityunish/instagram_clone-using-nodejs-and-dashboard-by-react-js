import { Button, Modal } from 'antd';

const ModalComponent = ({modalOpen,setModalOpen,sendstatus,deletepost,getallusers,postid}) => {

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
            key="submit23"
            type='dashed'
              onClick={sendstatus}
             
            >ok</Button>
        ]}
      >
        <div className='flex flex-col items-center gap-4'>
        <Button
            key="submit12"
            
           className='bg-red-600 '
           onClick={()=>{
            console.log(postid)
            // deletepost(postid);
            // getallusers();
           }}
            >Delete Post</Button>
              <Button
            key="su3bmit"
            type='primary'
            className='bg-blue-500 '
             
            >Edit Post</Button>
        </div>
        
        
      </Modal>
    </>
  );
};
export default ModalComponent;