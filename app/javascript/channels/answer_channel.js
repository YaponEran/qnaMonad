// import consumer from "./consumer"

// document.addEventListener("turbolinks:load", (e)=>{
//     let answerId = document.getElementById("answer_channel_provider")
//     let url = window.location.href
//     let question_id = url.slice(url.length - 1, url.length);
//     console.log(gon.question_id.id)

//     consumer.subscriptions.create({channel: "AnswerChannel", id: gon.question_id.id}, {

//         connected(){
//             console.log("Connected to question with " + question_id)
//         },

//         disconnected(){
//             console.log("discoeme")
//         },

//         received(data){
//             console.log(data)
//             let tmp = this.templelaterCreate(data)
//             answerId.innerHTML = tmp
//         },

//         templelaterCreate(data){
//             return `
//                 <p class="tag is-warning is-pulled-right ml-2">${data.rate}</p>
//             `
//         }
//     })
// })