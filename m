Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=knb1bzk1wgQfRmUEZZm5fAgOyx9RKkUq4hzJDeUIhWE=;
	b=ZtQJSBOoNZcAPgPUMXz1bTAi8qmKZ8ewOufJX1RZIw006+1MxjaCeLnBa54mjrBuNs
	TRFxUAjUBWyZ//c4D7nA+dBva67Zt1t4BOh9FaTcfJOnmB5bSss9/ex5JautPvkmWh3s
	bYqyES/c+UaAcvfbzuWp+iDwl/RK1tyfBZylc=
References: <1437667657-16954-1-git-send-email-nikolay@cumulusnetworks.com>
	<20150723095945.2b4dd59e@urahara>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <55B11EF4.8050501@cumulusnetworks.com>
Date: Thu, 23 Jul 2015 19:05:56 +0200
MIME-Version: 1.0
In-Reply-To: <20150723095945.2b4dd59e@urahara>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: stp: when using userspace stp stop
 kernel hello and hold timers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On 07/23/2015 06:59 PM, Stephen Hemminger wrote:
> On Thu, 23 Jul 2015 09:07:37 -0700
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> +		/* Stop hello and hold timer */
>> +		spin_lock_bh(&br->lock);
>> +		del_timer(&br->hello_timer);
>> +		list_for_each_entry(p, &br->port_list, list)
>> +			del_timer(&p->hold_timer);
>> +		spin_unlock_bh(&br->lock);
> 
> Wouldn't it be easier to use del_timer_sync here?
> 
I think it should work. Also I have an error in the commit message
about the kernel BPDU sending which I need to correct. I'll prepare
a v2 with your suggestion and fixed commit message.

Thanks,
 Nik
