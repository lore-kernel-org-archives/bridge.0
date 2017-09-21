Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=m0YcFqP9PA920hMOBtoglLXalRH3lACJwFRq7MxGtjI=;
	b=DJ6IqKf+8t9P+JB5kubTzkk/kg07z71xqs0We/DsF9KWqHuOruBh6vQJV0lgt4NGQw
	l1YW7I6xbmVTnQbIUCSD8iqPuIVpZwu1JCkIs8Lh6pQ0LQDVvdaoNrzKAgF1B3VkYyqe
	llqXYkdVeHUgdpTodEizq0XF94CRfBGUSJIbA=
MIME-Version: 1.0
In-Reply-To: <87h8vw5pwg.fsf@luffy.cx>
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
	<20170920.140956.781667692297467325.davem@davemloft.net>
	<16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
	<20170920162140.369bb198@xeon-e3> <87h8vw5pwg.fsf@luffy.cx>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Thu, 21 Sep 2017 08:09:28 -0700
Message-ID: <CAJieiUgKO-O3YFc3iTQXMmXc287RGgw4FjYhaLn-7+pmA_Fh+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
 when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>

On Thu, Sep 21, 2017 at 3:04 AM, Vincent Bernat <vincent@bernat.im> wrote:
>  =E2=9D=A6 20 septembre 2017 16:21 -0700, Stephen Hemminger <stephen@netw=
orkplumber.org> :
>
>> The one concern is that ports added or removed through ioctl should
>> cause same events as doing the same thing via netlink. Some users use
>> brctl (ioctl) and others use newer bridge (netlink) API.
>
> I'll make a third iteration to have the same notifications when using
> ioctl() with details in the commit message.
> --

as long as the ioctl path for bridge port removal is generating a:
RTM_DELLINK with AF_BRIDGE and
RTM_NEWLINK with AF_UNSPEC with 'master' removed

we should be good. These are the most important ones.

are there other specific bridge-events missing ?. you might want to
run `bridge monitor link` also. and un-slaving of a port also triggers
fdb events which are visible under `bridge monitor fdb`
