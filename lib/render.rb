# -*- coding: utf-8 -*-
require 'opengl'
require 'glu'
require 'glut'
require_relative 'grid'

include OpenGL
include GLU
include GLUT

OpenGL.load_dll('libGL.so', '/usr/lib')
GLU.load_dll('libGLU.so', '/usr/lib')
GLUT.load_dll('libglut.so', '/usr/lib')

GRID = Grid.new([9, 10], [10, 10], [11, 10])

def display
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  glPointSize(4.0)
  glBegin(GL_POINTS)
  
  glColor3f(0.0, 1.0, 0.0)

  GRID.state.each do |cell|
    glVertex2f(cell.first * 4, cell.last * 4)
  end

  glEnd
  glutSwapBuffers
end

def reshape(width, height)
  glViewport(0, 0, width, height)

  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluOrtho2D(0.0, width.to_f, 0.0, height.to_f)

  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity
end

def keyboard(key, x, y)
  case key
  when 27 # 27 == ESC
    exit
  end
end

def timer(value)
  GRID.iterate
  glutTimerFunc(0, GLUT.create_callback(:GLUTTimerFunc, method(:timer).to_proc), value)
  glutPostRedisplay
end

if __FILE__ == $0
  glutInit([1].pack('I'), [''].pack('p'))
  glutInitDisplayMode( GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH )
  glutInitWindowSize(500, 500)
  glutInitWindowPosition(100, 100)
  glutCreateWindow('Game of Life')
  glutDisplayFunc(GLUT.create_callback(:GLUTDisplayFunc, method(:display).to_proc))
  glutReshapeFunc(GLUT.create_callback(:GLUTReshapeFunc, method(:reshape).to_proc))
  glutKeyboardFunc(GLUT.create_callback(:GLUTKeyboardFunc, method(:keyboard).to_proc))
  glutTimerFunc(0, GLUT.create_callback(:GLUTTimerFunc, method(:timer).to_proc), 0)

  glClearColor(0.0, 0.0, 0.0, 1)

  glEnable(GL_DEPTH_TEST)
  glDisable(GL_POINT_SMOOTH)
  glDepthFunc(GL_LESS)

  glutMainLoop
end
