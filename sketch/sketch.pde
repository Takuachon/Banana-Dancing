/*
  Andor Salga
  Particle System
  Processing compliant
*/

import processing.opengl.*;

ParticleSystem psys;
int NUM_PARTICLES = 100;

class Particle{
  PVector position;
  PVector velocity;
  
  float age;
  float lifeTime;
  float opacity;
  float size;
  
  Particle(){
    position = new PVector(0, 0, 0);
    velocity = new PVector(1.5, 1.2, 2.0);
    
    age = 0;
    lifeTime = 0;
    opacity = 255;
    size = 20;
  }
  
  float getAge(){return age;}
  float getLifeTime(){return lifeTime;}
  
  void setAge(float a){age = a;}
  void setPosition( PVector pos){position = pos;}
  void setVelocity(PVector vel){velocity = vel;}
  void setLifeTime(float l){lifeTime = l;}
  
  void reset(){
    opacity = 255;
    size = 20;
  }
  
  void update(){
    age += 0.1; //fix
    
    velocity.y += 0.1;
    
    position.add(velocity);
    
    opacity = 255 - 250*(age/lifeTime);
    size = 20 - 20*(age/lifeTime);
  }
  
  void draw(){
    strokeWeight(size);
    stroke(opacity-50, 0, 255-opacity,opacity/3);
    point(position.x, position.y, position.z);
  }
}

class ParticleSystem{
  ArrayList p;

  ParticleSystem(){
    p = new ArrayList();
    for(int i = 0; i < NUM_PARTICLES; i++){
      Particle particle = new Particle(); 
      p.add(particle);
      resetParticle(i);
    }
  }
  
  void resetParticle(int i){
    Particle particle = (Particle)p.get(i);
    particle.reset();
    
    particle.setPosition( new PVector(mouseX, mouseY, 0));
    particle.setVelocity( new PVector( random(0,2), random(0,2) , 0 ) );
    particle.setLifeTime(random(1,15));
    particle.setAge(0);
  }
  
  void update(){
    for(int i = 0; i < NUM_PARTICLES; i++){
      Particle particle = (Particle)p.get(i);
      particle.update();
      if(particle.getAge() > particle.getLifeTime()){
        resetParticle(i);
      }
    }
  }
  
  void draw(){
    for(int i=0; i < NUM_PARTICLES; i++){
      Particle particle = (Particle)p.get(i);
      particle.draw();
    }
  }
}

void setup(){
  size(500, 500, OPENGL);
  psys = new ParticleSystem();
}

void draw(){
  background(0);
  stroke(255);
  psys.update();
  psys.draw();
}