Return-Path: <srinivas.aji@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Oe38HN+yZzSv+G7zEnuqW3DzbTIs+WoBuIwY3eN8GT4=;
	b=E7wwJ4lKP9zFqiEfO7x0F9LBIkqUqogWZfGjq5ikngw59OQtt+uu8BDKu7xCdImBvJ
	PuQ4ikiKsw3348ji+RfklHq3dqcOXwCoF3zmcGwxwgYiGSFSt7gfaDHGqCr79RChUk7p
	AXoE5p7kvUXIYy4eeYDTVwqEHXSmFlTnuh8p98JrynPxu9JJzbXsIS1Ur+gDgwa6KREq
	hqTtfJkRZhX2ezFWSJOYlKIyQwPVj8OWTvFfd4R0V9Is4HllTBAfnbLixDuOoiX4axmj
	QCZpaLin6MHUdpikdj02cYjiTT2Yz1QZOiCdciGbW9KJNhbeD6D1wz+nAzQA8hHLJKmJ
	44EA==
MIME-Version: 1.0
In-Reply-To: <CAAtMjxZGZc6+xDhUqLVGrhVwhy33AHft8DU-Rf+tX3ahzs4iRA@mail.gmail.com>
References: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
	<20161213094128.3fa3f4a5@xeon-e3>
	<CAAtMjxYTtqk3f5ucZuhP=Uv+bJR7NEYPXrB_vUtX+MpzoMt78Q@mail.gmail.com>
	<20161213111649.4d983c5f@xeon-e3>
	<CAAtMjxZGZc6+xDhUqLVGrhVwhy33AHft8DU-Rf+tX3ahzs4iRA@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Date: Wed, 14 Dec 2016 13:31:29 +0530
Message-ID: <CANbryT9wiSF1=wwb6Rfo9D27Oi5Ra858tQ6=HCLS-OZuZ9OX3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Bridge interface not forwarding DHCP-Broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Balaji J <ping2balaji@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, Dec 14, 2016 at 7:33 AM, Balaji J <ping2balaji@gmail.com> wrote:

> In the following article it is quoted that dhclient can be run on the
> interface attached to the bridge:
> https://wiki.linuxfoundation.org/networking/bridge

>  # brctl setfd br0 0
>  # brctl addif br0 eth0
>  # dhclient eth0

This seems like a typo. It should be "dhclient br0" just like the
"dhclient mybridge" in an example further up in the page.
