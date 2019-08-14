Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WaTpDcNJiFZ4IX53WMjagAg27UGU/T1qAMZT3ZurcgM=;
	b=IPxN8Jas+/uH5XGOyP1zFTo6cyC+dxOCOwsRWzAF/DXb+/ZAyQrLYV9ajpXQZEK1PJ
	o6pCQNuei16cetLhbZTmWt9ZbquwZTsHkN9Z0EjN0D48sLX50LKJKpTLS+JLHNnXU8vh
	Nn+oWRzJFG/tq7mCHEWJOZGE++KBtJSnfUd10=
References: <20190813141804.20515-1-pruddy@vyatta.att-mail.com>
	<20190813195341.GA27005@splinter>
	<43ed59db-9228-9132-b9a5-31c8d1e8e9e9@cumulusnetworks.com>
	<620d3cfbe58e3ae87ef1d5e7f2aa1588cac3e64a.camel@vyatta.att-mail.com>
	<20190814201138.GE2431@otheros>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <d0be5038-e76f-d21b-a034-e450cbb3010e@cumulusnetworks.com>
Date: Wed, 14 Aug 2019 23:34:47 +0300
MIME-Version: 1.0
In-Reply-To: <20190814201138.GE2431@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Cc: Ido Schimmel <idosch@idosch.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

On 8/14/19 11:11 PM, Linus Lüssing wrote:
> On Wed, Aug 14, 2019 at 05:40:58PM +0100, Patrick Ruddy wrote:
>> The group is being joined by MLD at the L3 level but the packets are
>> not being passed up to the l3 interface becasue there is a MLD querier
>> on the network
>>
>> snippet from /proc/net/igmp6
>> ...
>> 40   sw1             ff0200000000000000000001ff008700     1 00000004 0
>> 40   sw1             ff020000000000000000000000000002     1 00000004 0
>> 40   sw1             ff020000000000000000000000000001     1 0000000C 0
>> 40   sw1             ff010000000000000000000000000001     1 00000008 0
>> 41   lo1             ff020000000000000000000000000001     1 0000000C 0
>> 41   lo1             ff010000000000000000000000000001     1 00000008 0
>> 42   sw1.1           ff020000000000000000000000000006     1 00000004 0
>> 42   sw1.1           ff020000000000000000000000000005     1 00000004 0
>> 42   sw1.1           ff0200000000000000000001ff000000     2 00000004 0
>> 42   sw1.1           ff0200000000000000000001ff008700     1 00000004 0
>> 42   sw1.1           ff0200000000000000000001ff000099     1 00000004 0
>> 42   sw1.1           ff020000000000000000000000000002     1 00000004 0
>> 42   sw1.1           ff020000000000000000000000000001     1 0000000C 0
>> 42   sw1.1           ff010000000000000000000000000001     1 00000008 0
>> ...
>>
>> the bridge is sw1 and the l3 intervace is sw1.1
> 
> What kind of interface is sw1.1 exactly? Is it a VLAN or a VRF
> interface? Something else?
> 
+1

> Could you also post the output of bridge mdb show?
> 
> Regards, Linus
> 
> 
> PS: Also please include the bridge mailinglist in the future.
> 

Note that if you'd like to debug a host joined group currently bridge mdb show
will not dump it and if the group is host-joined only it
can even be empty. You can use my latest set (not applied yet):
http://patchwork.ozlabs.org/project/netdev/list/?series=125169

Alternatively you could monitor the mdb events, it will show up there even
today without any changes (bridge monitor mdb) and you can check if it's
getting deleted.

Cheers,
 Nik
