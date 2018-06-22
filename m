Return-Path: <garrmcnu@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nlO5I83twLO+Emceqld392FNpdsWCF7e5WpKWesagFQ=;
	b=YUBjx3YgfZCFo5R/wNkuY8I/UlAfjJP5T+jlTsl1kcoXfSinm8NskMn2Eh7FXT6g9J
	Bie6liy8P5GjrbLjUzTdCrOiYHGyyJyoSV9h7F9CtbNiYqDW7Ky21Jn7Yt2yGxlD/Dka
	9mrLit35B2P44HtFi9IaJuplBJ3PCR83GV0ev57KS9s28eDZKZSHQ1u9GypNo1fDKR80
	NWzlottRFxMGJOWCi8RE9+qtE0G5irnvGy8QWpQFc9JLG1QyD9Ia9d35j0vdZW0wHq6l
	LSqjXHFng+u4EEg94HbD66KD640VDAZDgzrQIDdCUfAnO2wa/mcUJ5QH3AOr6EKy3y3B
	EU+Q==
MIME-Version: 1.0
References: <20180621201427.4961-1-garrmcnu@gmail.com>
	<20180622.072056.1223319763674661318.davem@davemloft.net>
	<e4fb2883-1643-a921-a138-d1255831a9bd@cumulusnetworks.com>
In-Reply-To: <e4fb2883-1643-a921-a138-d1255831a9bd@cumulusnetworks.com>
From: Garry McNulty <garrmcnu@gmail.com>
Date: Fri, 22 Jun 2018 20:05:45 +0100
Message-ID: <CANysgeEFOnu6DxbpV2oA3=tvz+qJnfNy=TmG=cpRndcLmCNe1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] net: bridge: fix potential null pointer
 dereference on return from br_port_get_rtnl()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net

On Fri, 22 Jun 2018 at 00:35, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
>
> On 06/22/2018 01:20 AM, David Miller wrote:
> > From: Garry McNulty <garrmcnu@gmail.com>
> > Date: Thu, 21 Jun 2018 21:14:27 +0100
> >
> >> br_port_get_rtnl() can return NULL if the network device is not a bridge
> >> port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
> >> br_port_fill_slave_info() callbacks dereference this pointer without
> >> checking. Currently this is not a problem because slave devices always
> >> set this flag. Add null check in case these conditions ever changye.
> >>
> >> Detected by CoverityScan, CID 1339613 ("Dereference null return value")
> >>
> >> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> >
> > I don't think this is reasonable.
> >
> > The bridge code will never, ever, install a slave that doesn't have
> > that bit set.  It's the most fundamental aspect of how these objects
> > are managed.
> >
> +1
>
> This keeps coming up, here's the previous one:
> https://patchwork.ozlabs.org/patch/896046/
>
> Please do a more thorough check if these conditions can actually occur.
> In this case, as Dave said, they cannot.
>
> To be explicit as with the patch I mentioned above:
> Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>
> You can find more info in my reply to the patch above.
>
> Thanks,
>  Nik

Thanks for reviewing and for the feedback.

Regards

Garry
