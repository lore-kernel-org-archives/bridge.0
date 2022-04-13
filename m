Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=efy0+EnQP5PJX65iN7lLdABg99YrXmm11VO8VbF4k54=;
 b=DNxHKkvgH+pJLWotvx+1iV3jxDIC1IBaRM0JYVNzLxZpg99AI9DOHXVy9xzShoefMi
 Vkpwf5I7PpgCZ1MaGSbhNugcWxYjKoEVoYgIT9h6L1IRDGQBn4g+sOmrqSSgVdesD2hS
 rbD7AGmGI2ZlRD4MA2U5+Q6qA9yGsowVyP9BjO24FR3A7jDY4gI8TWG33U2NkQA957hb
 MFexZtOHlHMrN6otqs/Dv14pz4bFVUA2mN2sMgEf0nA4l2I3dR4XkrGCkPCoB4kzOKYi
 ITZRpG5ZdC4oRuiW6qUIFlTQtDmyi8jiv5556Shmy7nfJfxHJp4p1yjEKSGM6vPzanw2
 ZoJA==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <2cf8c40c-c122-24c0-1c01-b61da9830e9d@blackwall.org>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-2-troglobit@gmail.com>
 <99b0790a-9746-ea08-b57e-52c53436666d@blackwall.org>
 <87k0bt9uq9.fsf@gmail.com>
 <2cf8c40c-c122-24c0-1c01-b61da9830e9d@blackwall.org>
Date: Wed, 13 Apr 2022 12:09:28 +0200
Message-ID: <87czhl9twn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 01/13] net: bridge: add control of
	bum flooding to bridge itself
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Wed, Apr 13, 2022 at 12:58, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 13/04/2022 12:51, Joachim Wiberg wrote:
>> Interesting, you mean by speculatively setting local_rcv = true and
>> postpone the decsion to br_pass_frame_up(), right?  Yeah that would
>> indeed be a bit more work.
> Yes, I was thinking maybe local_rcv can become an enum with an exact reason for the
> local_rcv, so if it's > 0 do the local_rcv and br_pass_frame_up() then
> can make a proper decision without passing all of the vars. I haven't tried it,
> so not sure if it's feasible. :)

Ah, yeah that could definitely work. Thanks, I'll keep that in mind! :)
