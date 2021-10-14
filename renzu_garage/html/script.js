var CurrentVehicle = {};
var CurrentVehicle_ = {};
var VehicleArr = []
var garage_id = undefined
var currentcar
var chopper = false
var inGarageVehicle = {}
window.addEventListener('message', function(event) {
    var data = event.data;
    if (event.data.type == "returnveh") {
        returnveh();
    }
    if (event.data.type == "cleanup") {
        cleanup()
    }
    if (event.data.type == "onimpound") {
        onimpound();
    }
    if (event.data.garage_id) {
        garage_id = event.data.garage_id
    }
    if (event.data.type == "ownerinfo") {
    var utcSeconds = event.data.chopstats;
    const milliseconds = utcSeconds * 1000 // 1575909015000
    const dateObject = new Date(milliseconds)
    const humanDateFormat = dateObject.toLocaleString()
        document.getElementById("dateissue").innerHTML = humanDateFormat;
        for(var [key,value] of Object.entries(data.info)){
            for(var [k,v] of Object.entries(value)){
                if (k == 'firstname') {
                    document.getElementById("ownerinfo").innerHTML = ''+v+' '+value.lastname+'';
                }
                if (k == 'phone_number') {
                    document.getElementById("contact").innerHTML = v;
                }
                if (k == 'job') {
                    document.getElementById("job").innerHTML = v;
                }
            }     
        }
    }
    if (event.data.chopper) {
        chopper = true
    }
    if (event.data.type == "stats") {
        if (event.data.show) {
            document.getElementById("perf").style.display = 'block';
            if (!event.data.public) {
                document.getElementById("seemod").style.display = 'block';
            }
            for(var [k,v] of Object.entries(event.data.perf)){
                if (k =='name' || k =='plate' || k =='turbo') {
                    if (v == 'Not Installed') {
                        document.getElementById(k).style.color = 'grey';
                    } else if (v == 'Installed') {
                        document.getElementById(k).style.color = 'lime';
                    }
                    document.getElementById(k).innerHTML = v;
                } else {
                    document.getElementById(k).style.width = ''+v+'%';
                }
            }
        } else {
            document.getElementById("perf").style.display = 'none';
            document.getElementById("seemod").style.display = 'none';
        }
    }
    if (event.data.type == "display") {
        chopper = false
        if (event.data.chopper) {
            chopper = true
        }
        VehicleArr = undefined
        currentcar = undefined;
        VehicleArr = [];
        CurrentVehicle = [];
        $("#garage").fadeIn();
        for(var [key,value] of Object.entries(data.data)){   
            for(var [k,v] of Object.entries(value)){
                VehicleArr.push(v);          
            }             
        }
        Renzu_Garage.Open(VehicleArr);
        ShowVehicle(0);
    }

    if (event.data.type == "hide") {
        $("#garage").fadeOut();
    }

    if (event.data.type == "notify") {       
        var data = event.data;

        $("#messagePopup").css("background-color","rgb(252, 0, 0)");      

        $("#messagePopup").fadeIn(500);      
        
        $('#messagePopup').append(`

        <span>`+ data.message +`</span>    
        
        `)
        
        setTimeout(function(){ $("#messagePopup").fadeOut(500);         document.getElementById("messagePopup").innerHTML = ''; }, 3000);

    }

});

$(document).ready(function() {
    $('.upper-bottom-container').on('afterChange', function(event, slick, currentSlide) {
        
        $('.button-container').appendTo(currentSlide);
    });

    var app = '<div class="container">\
    <div class="right">\
      <div class="app">\
        <div class="app_inner" id="vehlist">\
        </div>\
      </div>\
    </div>\
  <div id="closemenu" class="modal" style="background-color:#050505c5 !important; color:#fff;">\
  </div>\
  <div class="middle-left-container">\
      <div class="column" id="vehicleclass"> \
      </div>\
      <div class="column" id="nameBrand">\
      </div>\
      <div class="column menu-modifications" style="right:50px; position:absolute;top:-20px;">\
          <div class="row" id="confirm"> <button class="confirm_out" style="background:#0454FE;color:#fff !important; border-radius: 10px;" onclick="garage()"> <i class="fad fa-garage"></i> Go to Garage </button> </div>\
      </div>\
  </div>\
  <div class="middle-left2-container">\
      <div class="column" id="contentVehicle">\
      </div>\
  </div>\
  <div id="messagePopup">\
  </div>\
  <div class="bottom-container"></div>\
  <div class="top-triangle"></div>\
</div>'

$('#garage').append(app);
});

function ShowVehicle(currentTarget) {
        var data = inGarageVehicle[currentTarget]
        if (currentcar !== currentTarget) {
            currentcar = currentTarget
            var div = $(this).parent().find('.active');        
            $(div).removeClass('active');
            var itemDisabled = false;
            if(!itemDisabled && garage_id != 'impound') {
                $(currentTarget).addClass('active');
                $('.modal').css("display","none");

                document.getElementById("nameBrand").innerHTML = '';
                document.getElementById("vehicleclass").innerHTML = '';
                document.getElementById("contentVehicle").innerHTML = '';
                          
                document.getElementById("vehicleclass").innerHTML = ' <img id="vehicle_class_image" src="https://forum.cfx.re/uploads/default/optimized/3X/0/3/0301f645963889531fb4870e8d47f2f7da7f1c45_2_1024x1024.gif">';

                $('#nameBrand').append(`
                    <span id="vehicle_class">`+data.brand+`</span> 
                    <span id="vehicle_name">`+data.name+`</span> 
                `);

                $(".menu-modifications").css("display","block");

                CurrentVehicle = {brand: data.brand, modelcar: data.model2, sale: 1, name: data.name, props: data.props }
                $('#contentVehicle').append(`
                    <div class="row spacebetween">
                        <span class="title">HANDLING</span>
                        <span>`+data.handling.toFixed(1)+`</span>
                    </div>

                    <div class="row">
                    <div class="w3-border" style="width: 100%;
                    margin-left: 10px;"> <div class="w3-grey" style="height:5px;width:`+data.handling.toFixed(1)/10*100+`%"></div> </div>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">TOP SPEED</span>
                        <span>`+data.topspeed.toFixed(0)+` KM/H</span>
                    </div>

                    <div class="row">
                    <div class="w3-border" style="width: 100%;
                    margin-left: 10px;"> <div class="w3-grey" style="height:5px;width:`+data.topspeed.toFixed(1)/520*100+`%"></div> </div>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">HORSE POWER</span>
                        <span>`+data.power.toFixed(0)+` HP</span>
                    </div>

                    <div class="row">
                    <div class="w3-border" style="width: 100%;
                    margin-left: 10px;"> <div class="w3-grey" style="height:5px;width:`+data.topspeed.toFixed(1)/500*100+`%"></div> </div>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">TORQUE</span>
                        <span>`+data.torque.toFixed(0)+` TQ</span>
                    </div>

                    <div class="row">
                    <div class="w3-border" style="width: 100%;
                    margin-left: 10px;"> <div class="w3-grey" style="height:5px;width:`+data.torque.toFixed(1)/500*100+`%"></div> </div>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">BRAKE</span>
                        <span>`+data.brake.toFixed(1)+`</span>
                    </div>

                    <div class="row">
                    <div class="w3-border" style="width: 100%;
                    margin-left: 10px;"> <div class="w3-grey" style="height:5px;width:`+data.brake.toFixed(1)/2*100+`%"></div> </div>
                    </div>
                `);
                if (chopper) {
                    $.post("https://renzu_garage/SpawnChopper", JSON.stringify({ modelcar: data.model2, price: 1, props: data.props }));
                } else {
                    $.post("https://renzu_garage/SpawnVehicle", JSON.stringify({ modelcar: data.model2, price: 1, props: data.props }));
                }
            } else if(!itemDisabled && garage_id == 'impound') {
                $(currentTarget).addClass('active');         
                $('.vehiclegarage').animate({scrollLeft:scrollAmount}, 'fast');

                $('.modal').css("display","none");

                document.getElementById("nameBrand").innerHTML = '';
                document.getElementById("vehicleclass").innerHTML = '';
                document.getElementById("contentVehicle").innerHTML = '';
                          
                document.getElementById("vehicleclass").innerHTML = ' <img id="vehicle_class_image" src="https://forum.cfx.re/uploads/default/optimized/3X/0/3/0301f645963889531fb4870e8d47f2f7da7f1c45_2_1024x1024.gif">';

                if (data !== undefined && data.brand !== undefined && data.name !== undefined) {
                    $('#nameBrand').append(`
                        <span id="vehicle_class">`+data.brand+`</span> 
                        <span id="vehicle_name">`+data.name+`</span> 
                    `);
                }

                $(".menu-modifications").css("display","block");
                if (data.brand == undefined) {
                    data.brand = 'Unknown'
                }
                CurrentVehicle = {brand: data.brand, modelcar: data.model2, sale: 1, name: data.name, props: data.props }
                $('#contentVehicle').append(`
                    <div class="handling-container">
                        <span>OWNER INFO</span>
                        <div class="handling-bar-container">
                        <div class="handling-line"></div>
                        <div class="handling-circle" style="left: 100%;"></div>
                    </div>
 

                    </div>

                    <div class="row spacebetween">
                        <span class="title">Owners name</span>
                        <span id="ownerinfo">Boy Ulol</span>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">CONTACT #</span>
                        <span id="contact">69</span>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">JOB</span>
                        <span id="job">Mafia</span>
                    </div>

                    <div class="row spacebetween">
                        <span class="title">DATE ISSUE</span>
                        <span id="dateissue">1/11/1111</span>
                    </div>
                `);
                $.post("https://renzu_garage/ownerinfo", JSON.stringify({ plate: data.plate, identifier: data.identifier, chopstatus: 1 }));
                $.post("https://renzu_garage/SpawnVehicle", JSON.stringify({ modelcar: data.model2, price: 1, props: data.props }));
            }
        }

}
function garage() {
    $.post("https://renzu_garage/gotogarage", JSON.stringify({id: garage_id }));
}

function ShowConfirm(){
    document.getElementById("closemenu").innerHTML = '';

    $('.modal').css("display","flex");

    $('#closemenu').append(`
        <div class="background-circle"></div>
        <div class="modal-content">
            <i style="    position: absolute;
            right: 20%;
            font-size: 40px;" class="fas fa-garage-car"></i>
            <p class="title">Confirm:</p>
            <p class="vehicle">Take Out Vehicle</p>
        </div>

        <div class="modal-footer">
            <div class="modal-buttons">     
                <div>
                    <span>Use</span>
                    <button id="money" class="modal-money button" onclick="GetVehicle('confirm')" >✔️</button>
                </div>
                <div>
                    <span>Cancel</span>
                    <button href="#!" id="card" class="modal-money button" onclick="GetVehicle('cancel')">X</button>
                </div>
            </div>
        </div>
    `);
}

function returnveh(){    
    document.getElementById("closemenu").innerHTML = '';

    $('.modal').css("display","flex");

    $('#closemenu').append(`
        <div class="background-circle"></div>
        <div class="modal-content">
            <p class="vehicle">Vehicle is outside of garage! - Do you Want to Deliver Here?</p>
        </div>

        <div class="modal-footer">
            <div class="modal-buttons">     
                <div>
                    <span>Pay</span>
                    <button id="money" class="modal-money button" onclick="returnvehicle('confirm')" >✔️</button>
                </div>
                <div>
                    <span>Cancel</span>
                    <button href="#!" id="card" class="modal-money button" onclick="returnvehicle('cancel')">X</button>
                </div>
            </div>
        </div>
    `);
}

function onimpound(){    
    document.getElementById("closemenu").innerHTML = '';

    $('.modal').css("display","flex");

    $('#closemenu').append(`
        <div class="background-circle"></div>
        <div class="modal-content">
            <p class="title">Ooops:</p>
            <p class="vehicle">Vehicle is Impounded</p>      

            <p>Brand: <span class="brand">`+CurrentVehicle_.brand+`</span></p>
            <p>Model: <span class="model">`+CurrentVehicle_.modelcar+`</span></p>
        </div>
    `);
}

function GetVehicle(option) {
    if (chopper) {
        $('.modal').css("display","none");
        VehicleArr = []
        switch(option){
            case 'cancel':
                break;
            case 'confirm':
                $.post('https://renzu_garage/flychopper', JSON.stringify(CurrentVehicle));
                CurrentVehicle_ = CurrentVehicle
                CurrentVehicle = {}
                break;
        }
    } else {
        $('.modal').css("display","none");
        VehicleArr = []
        switch(option){
            case 'cancel':
                break;
            case 'confirm':
                $.post('https://renzu_garage/GetVehicleFromGarage', JSON.stringify(CurrentVehicle));
                CurrentVehicle_ = CurrentVehicle
                CurrentVehicle = {}
                break;
        }
    }  
}

function returnvehicle(option) {
    $('.modal').css("display","none");
    VehicleArr = []
    switch(option){
        case 'cancel':
            break;
        case 'confirm':
            $.post('https://renzu_garage/ReturnVehicle', JSON.stringify(CurrentVehicle_));
            CurrentVehicle_ = {}
            break;
    }
}

function cleanup() {
    document.getElementById("vehlist").innerHTML = '';
}

var scrollAmount = 0

$(document).on('keydown', function(event) {
    switch(event.keyCode) {
        case 27: // ESC
            VehicleArr = []
            CurrentVehicle = {}
            $.post('https://renzu_garage/Close');  
            break;
        case 9: // TAB
            break;
        case 17: // TAB
            break;
    }
});

    $('.vehiclegarage').empty();
    $('.app_inner').empty();
    $("#garage").fadeOut();
(() => {
    Renzu_Garage = {};
    inGarageVehicle = {}
    Renzu_Garage.Open = function(data) {
        if (document.getElementById("vehlist")) {
            document.getElementById("vehlist").innerHTML = '';
        }
        for(i = 0; i < (data.length); i++) {
            var modelUper = data[i].model;
            inGarageVehicle[i] = data[i]
            $(".app_inner").append('<label style="cursor:pointer;"><input false="" id="tab-'+ i +'" onclick="ShowVehicle('+i+')" name="buttons" type="radio"> <label for="tab-'+ i +'"> <div class="app_inner__tab"> <span style="position:absolute;top:4px;left:8px;font-size:7px;color: #e2e2e2;;">Category: '+ data[i].brand +'</span> <span style="position:absolute;top:4px;right:5px;font-size:8px;color:#75ffb9;">Garage: '+ data[i].garage_id +'</span><h2 style="font-size:11px !important;"> <i class="icon" style="right:100px;"><img style="height:20px;" src="https://cdn.discordapp.com/attachments/709992715303125023/813351303887192084/wheel.png"></i> '+ data[i].name +' - Plate: '+ data[i].plate +' </h2> <div class="tab_left"> <i class="big icon"><img class="imageborder" style="min-width: 120px;height: 70px;border-radius: 10px;max-width: 120px;border-color: #c7c7c7;;" onerror="this.src=`https://i.imgur.com/Jdz2ZMK.png`;" src="../imgs/uploads/' + modelUper +'.jpg"></i>   </div> <div class="tab_right"> <p>Fuel Level: <div class="w3-border"> <div class="w3-grey" style="height:5px;width:'+ (data[i].fuel) +'%"></div> </div></p> <p>Body  Health: <div class="w3-border"> <div class="w3-grey" style="height:5px;width:'+ (data[i].bodyhealth * 0.1) +'%"></div> </div></p> <p>Engine Health: <div class="w3-border"> <div class="w3-grey" style="height:5px;width:'+ (data[i].enginehealth * 0.1) +'%"></div> </div></p><div class="row" id="confirm"> <button class="confirm_out" style="background:#0454FE" onclick="ShowConfirm()"> <i class="fad fa-garage-open"></i> Take Out </button> </div> </div> </div> </label></input></label>');    
        }     
    }
    Renzu_Garage.Open(VehicleArr)
})();