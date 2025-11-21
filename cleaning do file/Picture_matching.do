lab define pics1 3"The child runs" 5 "I don't know, no answer"
lab define pics2 3"People drink" 5 "I don't know, no answer"
lab define pics3 4"Children plant trees" 5 "I don't know, no answer"
lab define pics4 1"People make music." 5 "I don't know, no answer"
lab define pics5 1"The boy and the girl are looking out the window" 5 "I don't know, no answer"
lab define pics6 1"It was a little cold today. I needed my blanket to fall asleep" 5 "I don't know, no answer"
lab define pics7 3"People gather to make food together. They all add food to the pot" 5 "I don't know, no answer"
lab define pics8 3"The two boys are good friends. They like to sit under the tree and tell each other stories" 5 "I don't know, no answer"
lab define pics9 2"I love my mother. She works hard to take care of my family. I enjoy spending time with her. We enjoy cooking together. I am very grateful to my mother" 5 "I don't know, no answer"
lab define pics10 2"A group of friends gather to play after school. They sing some of the songs but they have no instruments. They usually play tide, jump rope or cat" 5 "I don't know, no answer"
lab define pics11 4"I love my mother. He is kind and loves his children. He works hard to provide for his family. Sometimes she works at the same time as babysitting! It always amazes me how selfless she is and how she carries her child. I am so grateful to my mother" 5 "I don't know, no answer"

lab values picture_matching_q1selection pics1
lab values picture_matching_q2selection pics2
lab values picture_matching_q3selection pics3
lab values picture_matching_q4selection pics4
lab values picture_matching_q5selection pics5
lab values picture_matching_q6selection pics6
lab values picture_matching_q7selection pics7
lab values picture_matching_q8selection pics8
lab values picture_matching_q9selection pics9
lab values picture_matching_q10selection pics10
lab values picture_matching_q11selection pics11

replace picture_matching_q2selection = 5 if !missing(picture_matching_q1selection) & picture_matching_q2selection == .
