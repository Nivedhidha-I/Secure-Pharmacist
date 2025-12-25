import './App.css';
import React from 'react'
import { useHistory } from "react-router-dom"

function Home() {
    const history = useHistory()
    const redirect_to_roles = () => {
        history.push('/roles')
    }
    const redirect_to_addmed = () => {
        history.push('/addmed')
    }
    const redirect_to_supply = () => {
        history.push('/supply')
    }
    const redirect_to_track = () => {
        history.push('/track')
    }
    return (
        <div>
            <div class='header'>
        <h1><a href="#">Secure Pharmacist</a></h1>
    </div>
    <div class="content">
        <h1>Pharmaceutical Supply Chain Flow</h1>
        <div class="box1">
            <h5>Order medicines</h5>
            <button onClick={redirect_to_addmed} className="btn btn-outline-light btn-sm mb-2">Order Medicines</button>
            <h5>Control Supply Chain</h5>
            <button onClick={redirect_to_supply} className="btn btn-outline-light btn-sm mb-2">Control Supply Chain</button>
            <hr />
            <br />
            <h5><b>Track</b> the medicines:</h5>
            <button onClick={redirect_to_track} className="btn btn-outline-light btn-sm mb-2">Track Medicines</button>
        </div>
    </div>
    <div class="footer">
        <p class="p-3">© copyrights International Centre for Emerging Technologies, Sri Ramachandra Engineering and Technology,
            SRIHER</p>
        <p class="p-3">By: Umar, Nivedhidha</p>            
            </div>
            </div>

        
        
        
    )
}

export default Home
