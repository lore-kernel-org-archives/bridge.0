Return-Path: <eldadzack@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
	:references:user-agent:mime-version:content-type;
	bh=Oklg1ngEe+EpcXqohAbgoNe3lqCUOqsowApvD0OHdsI=;
	b=UHiHV3kuJa4Lm7nzlluGYKM2XGu2Jjlw4Tp70jGZRONNfdeovUpRcYHfiEdPddcMMK
	MeuM4rl2JiaiOeW1WP5rmrG6ca7dR6fo7l/A0oCxmYyRQpjwiviIX085XWtGkPCWTKSQ
	Gno3Xp7IKP9Eixg+LZrXBsnwGtUwJFTb+PL0lopdu4bjnT7VjEogXtp8YqIY0sZdqdiC
	pD9A/YHQaOarWFPQxYt0iV/Kin0ZO07bCxjAIq/s3CpRKjj6B6mjjqspJEldTcVlqRoe
	3p3Wo0UoQbfJSxDXSbyq2tcQW9VwukBFeeLcEdlK954sgJQ3ar9VpGu5vvJLzJU281s8
	0UfQ==
Date: Thu, 17 May 2012 18:21:34 +0200 (CEST)
From: Eldad Zack <eldadzack@gmail.com>
In-Reply-To: <20120517090923.0d0930e9@nehalam.linuxnetplumber.net>
Message-ID: <alpine.DEB.2.02.1205171816310.22002@debianer>
References: <1337270425-21873-1-git-send-email-eldad@fogrefinery.com>
	<20120517090923.0d0930e9@nehalam.linuxnetplumber.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Bridge] [PATCH] ipv6: correct the ipv6 option name - Pad0 to
	Pad1
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jamal Hadi Salim <hadi@cyberus.ca>, James Morris <jmorris@namei.org>, "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org


On Thu, 17 May 2012, Stephen Hemminger wrote:
> On Thu, 17 May 2012 18:00:25 +0200
> Eldad Zack <eldad@fogrefinery.com> wrote:
> 
> > The padding destination or hop-by-hop option is called Pad1 and not Pad0.
> > 
> > See RFC2460 (4.2) or the IANA ipv6-parameters registry:
> > http://www.iana.org/assignments/ipv6-parameters/ipv6-parameters.xml
> > 
> > Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> 
> If standards bodies want to call a 0 a 1, then I guess we have to follow :-)

Yeah, Pad0 is a much better name for it. That's probably why it never
occured to any one for so long :-)
