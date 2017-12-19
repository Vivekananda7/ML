from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import sys

import numpy as np
import tensorflow as tf

FLAGS = None
IRIS_TRAINING = "iris_training.csv"
IRIS_TEST = "iris_test.csv"

def next_batch(num, data, labels):
    '''
    Return a total of `num` random samples and labels. 
    '''
    idx = np.arange(0 , len(data))
    np.random.shuffle(idx)
    idx = idx[:num]

    data_shuffle = [data[ i] for i in idx]
    labels_shuffle = [labels[ i] for i in idx]
    return np.asarray(data_shuffle), np.asarray(labels_shuffle)
	
def main(_):
  # Import data
  training_set = tf.contrib.learn.datasets.base.load_csv_with_header(
      filename=IRIS_TRAINING,
      target_dtype=np.int,
      features_dtype=np.float32)
  test_set = tf.contrib.learn.datasets.base.load_csv_with_header(
      filename=IRIS_TEST,
      target_dtype=np.int,
      features_dtype=np.float32)


  def get_train_inputs():
    x = training_set.data
    y1 = training_set.target
    w = 3
    h = len(y1)
    y = [[0 for x2 in range(w)] for y2 in range(h)]
    for i in range(0, len(y1)):
        y[i][y1[i]]=1

    return x, y

  def get_test_inputs():
    x = test_set.data
    y1 = test_set.target
    w = 3
    h = len(y1)
    y = [[0 for x2 in range(w)] for y2 in range(h)]
    for i in range(0, len(y1)):
        y[i][y1[i]]=1

    return x, y

  # Create the model
  x = tf.placeholder(tf.float32, [None, 4])
  W = tf.Variable(tf.zeros([4, 3]))
  b = tf.Variable(tf.zeros([3]))
  y = tf.matmul(x, W) + b
  # Define loss and optimizer
  y_ = tf.placeholder(tf.float32, [None, 3])

  cross_entropy = tf.reduce_mean(
      tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y))
  train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)

  sess = tf.InteractiveSession()
  tf.global_variables_initializer().run()
  # Train
  for _ in range(1000):
    a, b = get_train_inputs()
    batch_xs, batch_ys = next_batch(10,a,b)
    sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys})

  # Test trained model
  correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
  accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
  test_x, test_y=get_test_inputs()

  print(sess.run(accuracy, feed_dict={x: test_x,
                                      y_: test_y}))

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  FLAGS, unparsed = parser.parse_known_args()
  tf.app.run(main=main, argv=[sys.argv[0]] + unparsed)
