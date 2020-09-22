Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 22 Sep 2020 19:55:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
 t=1600797320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAT+1Bo7DvbvxFHYUbGR9cD0AOeb3oC01HODpW8Xb6A=;
 b=TLH6Fo6N2Za+3cD+15QuafRAkWk1liFkrXfyRYyOW+pMMGuaZcKk6Dp87xpRdwtgnVt3fJ
 qUKOHmPhFMnT6IGE4Rp4jaci5CQ2gj7PuWdtd+wWovffdk0SjbdZxjuJbzPBvFwn0eKK5c
 fsyKQfsaGzU1rmrHayQmkepxiyY47kuxIUiI74zs8JEwpzNvGRKuVMS3fXjJ8O4/HqTSJy
 bOIKoP6/l0uGYeFK5gi6/uPCPwwifdOxKNGUiFjFBXlrOTJ5apNC29T8cv7EZYGS/lmpFh
 SNvqSqcnbb5mDlIfgBQWYYzbuvID+DGchz/fN/6o8cPYIwpMrWUX+VKS0bukzQ==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20200922175519.GB10212@otheros>
References: <20200922073027.1196992-1-razor@blackwall.org>
 <20200922073027.1196992-7-razor@blackwall.org>
 <20200922175119.GA10212@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922175119.GA10212@otheros>
Subject: Re: [Bridge] [PATCH net-next v2 06/16] net: bridge: mcast: rename
 br_ip's u member to dst
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Antonio Quartulli <a@unstable.cc>, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, davem@davemloft.net

On Tue, Sep 22, 2020 at 07:51:19PM +0200, Linus Lüssing wrote:
> I don't see a "src" in br_ip in net-next/master at the moment. Or
> is that supposed to be added with your IGMPv3 implementation in
> the future?

Ah, sorry, found the according patch (*) it in my other inbox.
Nevermind.

(*): [PATCH net-next v2 04/16] net: bridge: add src field to br_ip 
https://patchwork.ozlabs.org/project/netdev/patch/20200922073027.1196992-5-razor@blackwall.org/
