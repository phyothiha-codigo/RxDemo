//
//  Person.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 16/08/2021.
//

import Foundation

struct PersonData: Codable {
    let score: Double
    let person: Person?
    
    init(score: Double, person: Person?) {
        self.score = score
        self.person = person
    }
}

struct Person: Codable {
    let id: Int
    let name: String?
    let gender: String?
    let birthday: String?
    let image: PersonImage?
    
    init(id: Int, name: String?, gender: String?, birthday: String?, image: PersonImage?) {
        self.id = id
        self.name = name
        self.gender = gender
        self.birthday = birthday
        self.image = image
    }
}

struct PersonImage: Codable {
    let medium: String?
    let original: String?
}

//[
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 5308,
//            "url": "https://www.tvmaze.com/people/5308/val-lauren",
//            "name": "Val Lauren",
//            "country":
//            {
//                "name": "United States",
//                "code": "US",
//                "timezone": "America/New_York"
//            },
//            "birthday": null,
//            "deathday": null,
//            "gender": "Male",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/191/479296.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/191/479296.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/5308"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 5768,
//            "url": "https://www.tvmaze.com/people/5768/kristi-lauren",
//            "name": "Kristi Lauren",
//            "country": null,
//            "birthday": "1994-01-19",
//            "deathday": null,
//            "gender": "Female",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/177/442566.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/177/442566.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/5768"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 6076,
//            "url": "https://www.tvmaze.com/people/6076/lauren-lefranc",
//            "name": "Lauren LeFranc",
//            "country": null,
//            "birthday": null,
//            "deathday": null,
//            "gender": null,
//            "image": null,
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/6076"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 6486,
//            "url": "https://www.tvmaze.com/people/6486/hope-lauren",
//            "name": "Hope Lauren",
//            "country":
//            {
//                "name": "United States",
//                "code": "US",
//                "timezone": "America/New_York"
//            },
//            "birthday": "1993-06-10",
//            "deathday": null,
//            "gender": "Female",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/144/361826.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/144/361826.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/6486"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 6800,
//            "url": "https://www.tvmaze.com/people/6800/lauren-graham",
//            "name": "Lauren Graham",
//            "country":
//            {
//                "name": "United States",
//                "code": "US",
//                "timezone": "America/New_York"
//            },
//            "birthday": "1967-03-16",
//            "deathday": null,
//            "gender": "Female",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/1/4960.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/1/4960.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/6800"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 9550,
//            "url": "https://www.tvmaze.com/people/9550/lauren-shiohama",
//            "name": "Lauren Shiohama",
//            "country": null,
//            "birthday": null,
//            "deathday": null,
//            "gender": null,
//            "image": null,
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/9550"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 9683,
//            "url": "https://www.tvmaze.com/people/9683/lauren-prejeant",
//            "name": "Lauren Prejeant",
//            "country": null,
//            "birthday": null,
//            "deathday": null,
//            "gender": null,
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/2/6951.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/2/6951.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/9683"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 9785,
//            "url": "https://www.tvmaze.com/people/9785/lauren-sanchez",
//            "name": "Lauren Sánchez",
//            "country":
//            {
//                "name": "United States",
//                "code": "US",
//                "timezone": "America/New_York"
//            },
//            "birthday": "1969-12-19",
//            "deathday": null,
//            "gender": "Female",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/195/489995.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/195/489995.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/9785"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 9809,
//            "url": "https://www.tvmaze.com/people/9809/lauren-pritchard",
//            "name": "Lauren Pritchard",
//            "country": null,
//            "birthday": null,
//            "deathday": null,
//            "gender": "Female",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/222/555634.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/222/555634.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/9809"
//                }
//            }
//        }
//    },
//    {
//        "score": 0.5,
//        "person":
//        {
//            "id": 3358,
//            "url": "https://www.tvmaze.com/people/3358/lauren-cohan",
//            "name": "Lauren Cohan",
//            "country":
//            {
//                "name": "United States",
//                "code": "US",
//                "timezone": "America/New_York"
//            },
//            "birthday": "1982-01-07",
//            "deathday": null,
//            "gender": "Female",
//            "image":
//            {
//                "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/175/439851.jpg",
//                "original": "https://static.tvmaze.com/uploads/images/original_untouched/175/439851.jpg"
//            },
//            "_links":
//            {
//                "self":
//                {
//                    "href": "https://api.tvmaze.com/people/3358"
//                }
//            }
//        }
//    }
//]
