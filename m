Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 14 Aug 2019 22:11:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1565813500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	in-reply-to:in-reply-to:references:references;
	bh=zwP/DJWHFexvMmej3C7q8t73rgsDcQJ5forpfODbiYo=;
	b=Wh4qqA7vCxQpUVySXP5/KuHzSBqJSgf9AR59887R9mTCCnFBi1RcUfuYiKzOaQMqI99rni
	MGKK/4IBAbluIo1a7jglf3Q5jLvRAGPmFszrafNVKMYXf4RjuVgaPKWm4mH6f08WHVmipF
	EX0d2Uu/BlzEkQ6U7V9pb78f1gVMdn114PSmdyQoOBIy8Tbt7j+cbTzc9pEP5J1oupUUTJ
	7wkgvJoJDQo48fnme7UkckC6yYMSyYqJF2hZItQzV1XQN8ZapY3p0S/aDOM3Hjyw5cY7Zt
	besvG8hGfznq60OxFz/B3Avvr2UFIEz6NGNTyCSq0j9ojtWdXPtWZIccZmidEA==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190814201138.GE2431@otheros>
References: <20190813141804.20515-1-pruddy@vyatta.att-mail.com>
	<20190813195341.GA27005@splinter>
	<43ed59db-9228-9132-b9a5-31c8d1e8e9e9@cumulusnetworks.com>
	<620d3cfbe58e3ae87ef1d5e7f2aa1588cac3e64a.camel@vyatta.att-mail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <620d3cfbe58e3ae87ef1d5e7f2aa1588cac3e64a.camel@vyatta.att-mail.com>
Subject: Re: [Bridge] [PATCH net-next] mcast: ensure L-L IPv6 packets are
 accepted by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Ido Schimmel <idosch@idosch.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

On Wed, Aug 14, 2019 at 05:40:58PM +0100, Patrick Ruddy wrote:
> The group is being joined by MLD at the L3 level but the packets are
> not being passed up to the l3 interface becasue there is a MLD querier
> on the network
> 
> snippet from /proc/net/igmp6
> ...
> 40   sw1             ff0200000000000000000001ff008700     1 00000004 0
> 40   sw1             ff020000000000000000000000000002     1 00000004 0
> 40   sw1             ff020000000000000000000000000001     1 0000000C 0
> 40   sw1             ff010000000000000000000000000001     1 00000008 0
> 41   lo1             ff020000000000000000000000000001     1 0000000C 0
> 41   lo1             ff010000000000000000000000000001     1 00000008 0
> 42   sw1.1           ff020000000000000000000000000006     1 00000004 0
> 42   sw1.1           ff020000000000000000000000000005     1 00000004 0
> 42   sw1.1           ff0200000000000000000001ff000000     2 00000004 0
> 42   sw1.1           ff0200000000000000000001ff008700     1 00000004 0
> 42   sw1.1           ff0200000000000000000001ff000099     1 00000004 0
> 42   sw1.1           ff020000000000000000000000000002     1 00000004 0
> 42   sw1.1           ff020000000000000000000000000001     1 0000000C 0
> 42   sw1.1           ff010000000000000000000000000001     1 00000008 0
> ...
> 
> the bridge is sw1 and the l3 intervace is sw1.1

What kind of interface is sw1.1 exactly? Is it a VLAN or a VRF
interface? Something else?

Could you also post the output of bridge mdb show?

Regards, Linus


PS: Also please include the bridge mailinglist in the future.
