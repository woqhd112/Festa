<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${root }resources/js/three.js"></script>
<script type="text/javascript" src="${root }resources/js/three.module.js"></script>
<script type="text/javascript" src="${root }resources/js/CSS3DRenderer.js"></script>

</head>
<body>
<script type="text/javascript">

   $(document).ready(function(){
   
      init();
      animate();
   
   });
   
   var camera, scene, renderer;
   var target = new THREE.Vector3();
   var lon = 90, lat = 0;
   var phi = 0, theta = 0;
   
   var touchX, touchY;
   function init(){
       
       camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 1000);
       scene = new THREE.Scene();
       
       var sides = [
           {
               url: '${upload}/4.jpg',
               position: [ -553, 0, 0 ],
               rotation: [ 0, Math.PI / 2, 0 ]
           },
           {
               url: '${upload}/2.jpg',
               position: [ 553, 0, 0 ],
               rotation: [ 0, -Math.PI / 2, 0 ]
           },
           {
               url: '${upload}/5.jpg',
               position: [ 0, 553, 0 ],
               rotation: [ Math.PI / 2, 0, Math.PI ]
           },
           {
               url: '${upload}/6.jpg',
               position: [ 0, -553, 0 ],
               rotation: [ -Math.PI / 2, 0, Math.PI ]
           },
           {
               url: '${upload}/3.jpg',
               position: [ 0, 0, 553 ],
               rotation: [ 0, Math.PI, 0 ]
           },
           {
               url: '${upload}/1.jpg',
               position: [ 0, 0, -553 ],
               rotation: [ 0, 0, 0 ]
           }
       ];
       
       for( var i=0; i<sides.length; i++){
           
           var side = sides[i];
           
           var element = document.createElement( 'img' );
           element.width = 1108;
           element.src = side.url;
           
           var object = new THREE.CSS3DObject( element );
           object.position.fromArray( side.position );
           object.rotation.fromArray( side.rotation );
           scene.add( object );
       }
       
       renderer = new THREE.CSS3DRenderer();
       renderer.setSize( window.innerWidth, window.innerHeight );
       document.body.appendChild( renderer.domElement );
       document.addEventListener( 'mousedown', onDocumentMouseDown, false );
       document.addEventListener( 'wheel', onDocumentMouseWheel, false );
       
       document.addEventListener( 'touchstart', onDocumentTouchStart, false );
       document.addEventListener( 'touchmove', onDocumentTouchMove, false );
       
       window.addEventListener( 'resize', onWindowResize, false );
   }
   
   function onWindowResize(){
       
       camera.aspect = window.innerWidth / window.innerHeight;
       camera.updateProjectionMatrix();
       
       renderer.setSize( window.innerWidth, window.innerHeight );
   }
   
   function onDocumentMouseDown(event){
       
       event.preventDefault();
       
       document.addEventListener( 'mousemove', onDocumentMouseMove, false );
       document.addEventListener( 'mouseup', onDocumentMouseUp, false );
   }
   
   function onDocumentMouseMove(event){
       
       var movementX = event.movementX || event.mozMovementX || event.webkitMovementX || 0;
       var movementY = event.movementY || event.mozMovementY || event.webkitMovementY || 0;
       
       lon -= movementX * 0.1;
       lat += movementY * 0.1;
   }
   
   function onDocumentMouseUp(){
       
       document.removeEventListener( 'mousemove', onDocumentMouseMove );
       document.removeEventListener( 'mouseup', onDocumentMouseUp );
   }
   
   function onDocumentMouseWheel(event){
      
       var fov = camera.fov + event.deltaY * 0.05;
       
       camera.fov = THREE.MathUtils.clamp( fov, 10, 75 );
       
       camera.updateProjectionMatrix();
   }
   
   function onDocumentTouchStart(event){
       
       event.preventDefault();
       
       var touch = event.touchs[0];
       
       touchX = touch.screenX;
       touchY = touch.screenY;
       
   }
   
   function onDocumentTouchMove(event){
       
       event.preventDefault();
       
       var touch = event.touchs[0];
       
       lon -= ( touch.screenX - touchX ) * 0.1;
       lat += ( touch.screenY - touchY ) * 0.1;
       
       touchX = touch.screenX;
       touchY = touch.screenY;
   }
   
   function animate(){
       
       requestAnimationFrame( animate );
       
       lon += 0.1;
       lat = Math.max( -85, Math.min( 85, lat ) );
       phi = THREE.MathUtils.degToRad( 90 - lat );
       theta = THREE.MathUtils.degToRad( lon );
       
       target.x = Math.sin( phi ) * Math.cos( theta );
       target.y = Math.cos( phi );
       target.z = Math.sin( phi ) * Math.sin( theta );
       
       camera.lookAt( target );
       
       renderer.render( scene, camera );
   }
</script>
</body>
</html>