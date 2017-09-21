Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Jo6qc29OUEBmlHnWUakZ87lfrzKUFhL0XwkvKSaBZcY=;
	b=t6mI6Y2olVAk3jdCU3oVSWI4dhnvPpckmbXw+nYKAsnAuyA1pGIJS6o/VSSU/mk5+Z
	zrUagNuRVvjdR+LvKNyKNbWc8MW2KgcVEt481jpz3cqoELzhOYSYxyUfaajHjoxCt49s
	W/qpbEb+aawbu9+XHOYTOGKu5+ogqu7Z9MM/+SCRZryiSmsbYlIJLck3KUl4pkaewwtG
	ZdJSVNtCt5f7l6Kg8q9HPL/G/+aDvyew46p20WTKQh+uznomi6Acfk7F85yZKSsFcKIR
	hVXaSr5vXbOY7konNLktcnjfE5rCW1vIOsybvbgGW4T0mBYRMMFK8IKpUu3iaDNtav+a
	IIrQ==
References: <20170920162140.369bb198@xeon-e3>
	<20170921100525.20395-1-vincent@bernat.im>
	<0cdf06b9-e67d-c035-e0f1-c4eb143bf631@gmail.com>
	<CAJieiUjqttMeC24CzDa8Y8g=opRKoa2hbG2Cb+78u632vA3uqw@mail.gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <4bd6834a-899a-b136-9886-249dadd5a6a6@gmail.com>
Date: Thu, 21 Sep 2017 11:29:55 -0600
MIME-Version: 1.0
In-Reply-To: <CAJieiUjqttMeC24CzDa8Y8g=opRKoa2hbG2Cb+78u632vA3uqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [net-next v3] bridge: trigger RTM_NEWLINK when
 interface is modified by bridge ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>, David Ahern <dsahern@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Vincent Bernat <vincent@bernat.im>, David Miller <davem@davemloft.net>

On 9/21/17 11:20 AM, Roopa Prabhu wrote:
> this patch seems fine...but ideally I would have assumed
> netdev_upper_dev_unlink which
> is eventually called in both paths would generate the RTN_NEWLINK
> IFF_MASTER in response
> to the NETDEV_CHANGEUPPER notifier. If we add it there now, it might
> need some more fixes
> to not generate redundant notifications for the netlink case.

Agreed and it is another pandora's box
