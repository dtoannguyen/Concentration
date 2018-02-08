# Concentration (Stanford University)

With this App you can play the card game "Concentration", also known as "Memory", on your iOS Device.
This is a project made in the Stanford's Course "Developing Applications for iOS" (CS193P, Fall 17/18).
My version includes possible solutions to the assignments (required tasks + extra credit tasks).

# Features

- shuffle cards
- match cards
- scoring system (+2 for found matches, -1 if selected card was flipped before and mismatched, bonus/deduction dependant on how much time it took to match/mismatch two cards)
- bonus/deduction system dependant on time (+2 if it took <0.75s to find a match, +1 if it took <1.00s to find a match, -2 if it took >2.25s to find a mismatch (at least one of the flipped cards where flipped before))
- label showing time bonus/deduction fades away
- restart button
- random theme (card color, strings (emojis) on card, background, labels and restart button are affected by themes, currently there are 4 themes)
- auto layout using container views

# Future Updates

- cleaner code
- choose theme
- choose difficulty level
- better animations

# Build With

- XCode 9
- Swift 4
- MVC Architecture

# Acknowledgement

Thanks to Paul Hegarty for the great iOS Course!

# What I've Learned in This Project

How to:
- use access control (private, private(set), fileprivate, asserts)
- use extensions properly
- use computed properties
- use static properties and static/mutating methods
- use filter method
- animate show and fade away text
- get time intervals (Date(), DateFormatter())
