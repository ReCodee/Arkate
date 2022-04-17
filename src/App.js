import logo from './logo.svg';
import './App.css';
import detectEthereumProvider from '@metamask/detect-provider';
import Web3 from 'web3';
import Arks from '../src/abis/Arks.json';
import { Component, useEffect, useState } from 'react';
import {MDBCard, MDBCardBody, MDBCardTitle, MDBCardText, MDBCardImage, MDBBtn} from 'mdb-react-ui-kit';
import './App.css';
import { Col, Container, Row } from 'react-grid-system';

class App extends Component {

  async componentDidMount() {
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    this.setState({
      account: accounts[0]
    })
    console.log(this.state.account);
      await this.loadWeb3();
      await this.blockchainData();
  }

  async loadWeb3() {
    const provider = await detectEthereumProvider();

    if ( provider) {
      console.log('Connected');
      window.web3 = new Web3(provider);
    } else {
      console.log('Not Connected'); 
    }
}

  async blockchainData() {
    await window.web3.eth.getAccounts()
    .then(console.log);
    var id = 0;
    await window.web3.eth.net.getId()
     .then(
       data => {
            id = data;  
       });
      
    const networkData = await Arks.networks[id];
    console.log(networkData);
    if ( networkData ) {
      const abi = Arks.abi;
      const address = networkData.address;
      //this.setState({account: address});
      console.log(this.state.account);
       const newcontract = new window.web3.eth.Contract(abi, address); 
        this.setState({contract: newcontract}); 
        console.log(this.state.contract);
        
      const totalSupply = await newcontract.methods.totalSupply().call();
      console.log(totalSupply);
      this.setState({
        totalSupply
      });
      // set_tS(totalSupply);
      for ( let i = 1 ; i <= totalSupply ; i++ ) {
        //console.log(await newcontract.methods.Arks[i - 1].call());
        const newarks = await newcontract.methods.arks(i - 1).call();
        this.setState({arks:[...this.state.arks, newarks]});
      }
       //console.log(this.state.arks);
    } 
  }

  mint = (Arks) => {
    this.state.contract.methods.mint(Arks).send({from: this.state.account})
    .once('receipt', (receipt) => {
      this.setState({
        arks:[...this.state.arks, Arks]
      })
    })
  }

constructor(props) {
    super(props);
    this.state = {
      account: '',
      contract: null,
      totalSupply: 0,
      arks:[]
    }
}

  render() {
    return (
        
      <div className='container-filled'>
        <nav className='navbar navbar-dar fixed-top bg-dark flex-md-nowrap p-0 shadow'>
          <div className='navbar-brand col-sm-3 col-md-3 mr-0'
          style={{color:'white'}} >
             Arkate NFTs    
          </div>
          <ul className='navbar-nav px-3'>
            <l className='nav-item'>
              <small className='text-white'>
                {this.state.account}
              </small>
            </l> 
          </ul>
        </nav>
        <div className='container-fluid mt-1'>
          <div className='row'>
            <main role='main'
            className='col'>
              <div className='content mr-auto ml-auto'
              style={{opacity:'0.8'}}>
                <h1 style={{color:'black'}}>
                   Arkate - A NFT Marketplace 
                   {console.log(this.state.arks)}  
                </h1>
                <form onSubmit={(event) => {
                  event.preventDefault()
                  const arks = this.arks.value;
                  this.mint(arks);
                }}>
                 <input
                 type='text'
                 placeholder='Add a file location'
                 className='form-control mb-1'
                 ref={(input) => this.arks = input}/>

                 <input 
                 style={{margin : '6px'}}
                 type='submit'
                 className='btn btn-primary btn-black'
                 value='MINT'
                 />

                </form>
              </div>
            </main>
          </div>
            <hr></hr>
            
              
              <div className='row-textCenter'>
              <Container>
                <Row>
                {this.state.arks.map((ark, key) => {
                 return (
                   <div>
                     <div>
                     <MDBCard className='token img' style={{maxWidth: '22rem'}}>
                       <MDBCardImage  src={ark} position='top' style={{marginRight:'4px'}}/>
                       <MDBCardBody>
                         <MDBCardTitle> Arkabte </MDBCardTitle>
                         <MDBCardText> Very Rare Arks that can grant the holder good luck, each ark is unique </MDBCardText>
                         <MDBBtn href={ark}>Download</MDBBtn>
                         </MDBCardBody>
                         </MDBCard>
                     </div>
                   </div>
                 )
              })}
              </Row>
              </Container>
            </div>
        </div>
      </div>  
    )
  }
}

export default App;
