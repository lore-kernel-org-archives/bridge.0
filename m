Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=zl+7gfDJz9BsvpvqzdPFohPM46pUukirvBHVMEMTM1o=;
	b=xIt42JoE3JPoV+mCzqJz94s77tkvsA/8cxcQ8rAzPxENnKXLsJPLm1r0Iwa2x+uw+i
	c/ppDaerlLP9C+//q2pMijWCpAyp0xKAfEgnEsa/lGWALHZKKVT1NIB58tQOR32N40b0
	W9YJ2beRTG5lucKen9pqAGNn8GrgOWbUXLYW9gIvoxHINCoDl4fW6csH7iZpcxyejnEa
	1omeMMT4ltLMqsFDzw56mONpFUB2s6b8ONRg1TBI2x+T51npCd4mHnUXj4M03xfkbKaj
	S3aXb1iqGHSTWgJnJs5BbgBCgLGTaeddq/BADMOTSaip3wm7ucXDnNJYaIOxqlH53JPn
	xDdw==
Message-ID: <54B5DAE8.6090907@gmail.com>
Date: Tue, 13 Jan 2015 19:56:40 -0700
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
References: <56868207.rHBDZL3pbk@wuerfel>
	<20150113.155740.1237959632603319909.davem@davemloft.net>
	<54B58AAC.7090001@gmail.com> <4681500.x6CYopasp1@wuerfel>
In-Reply-To: <4681500.x6CYopasp1@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: only provide proxy ARP when
	CONFIG_INET is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: cwang@twopensource.com, bridge@lists.linux-foundation.org, kyeyoonp@codeaurora.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>

On 1/13/15 2:33 PM, Arnd Bergmann wrote:

> The effect is very similar to my patch (probably same object code), the
> only difference should be that it would add an ugly #ifdef instead of
> the preferred IS_ENABLED() check, so you don't get any compile-time
> coverage of the function.

Indeed. As long as br_do_proxy_arp does not get exported that works the 
same.

David

