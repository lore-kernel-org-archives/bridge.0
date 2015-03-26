Return-Path: <m4rtntns@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=c91j8MOuWW+8C3Mm2SwNeFnOoMFPx42+qgnXEUMJtbE=;
	b=JBQXd7aHGIEaq4z/K1fDQDwxvXBtT7hex7P+wX9P8/afNFmbjxztK90AT2lDx3C0GK
	mhJFO9q1+GmsMc3jh7ij4WdmqgEvUacCWaAzAyh3mzwUJR36O5R/QYabExzcO1qrPrSM
	5JJKgspZyE/aIUAM+bcHfHvOBKky4j3HXoRqItdxkSCsCTfZvKdxDB3TaTKefqxDW1B2
	umsPeywlQv4SAWKFV8k3s9UbvqmEAFwkf6Ehx8WTHtM8NOXCMLc/raxGR25+1GJsphfD
	4jjqMTOyeHaddh1SE4dujwERF9Ah3/Wmeoxbow15yFru9xWfLyLKb7aIO5lbc60YYd62
	MNAg==
MIME-Version: 1.0
In-Reply-To: <20150325105903.18a0a9a5@uryu.home.lan>
References: <CAJx5YvG4G-f_u6svYeoCZsY5ZSXutgNz4g89PL8i1RQ==Z+0gg@mail.gmail.com>
	<20150325105903.18a0a9a5@uryu.home.lan>
Date: Thu, 26 Mar 2015 14:25:28 +0200
Message-ID: <CAJx5YvGvDfhNpPWVyFL7H=bc+DPx+wbLzN0KhzoY6y__XppVpg@mail.gmail.com>
From: Martin T <m4rtntns@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] Are multicast Ethernet frames supported in Linux
	bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: bridge@lists.linux-foundation.org

Stephen,

thanks! Once I disabled multicast snooping under
/sys/devices/virtual/net/br0/bridge/multicast_snooping, then bridge
started to forward multicast Ethernet frames.


Martin

On 3/25/15, Stephen Hemminger <stephen@networkplumber.org> wrote:
> On Wed, 25 Mar 2015 11:01:57 +0200
> Martin T <m4rtntns@gmail.com> wrote:
>
>> Hi,
>>
>> I have a network topology where in "Dell PE860" runs a Linux
>> virtual-switch br0:
>>
>> http://s24.postimg.org/j1un2gs9h/virtual_bridge.png
>>
>> Now if I send an Ethernet frame to broadcast address from "IBM
>> ThinkCentre":
>>
>> 17:10:23.569021 00:a1:ff:01:02:05 > ff:ff:ff:ff:ff:ff, ethertype IPv4
>> (0x0800), length 34: 127.0.0.1 > 127.0.0.1:  ip-proto-0 0
>>
>> ..then I see this frame in both virtual-machines as I should. If I
>> send an Ethernet frame to MAC address which is not known in br0 MAC
>> address table, then the br0 also behaves correctly and floods the
>> frame to all ports expect to one where the frame came in(eth1 in this
>> example). However, if I send a multicast frame from "IBM ThinkCentre":
>>
>> 17:17:05.513283 00:a1:ff:01:02:05 > 01:33:44:55:66:77, ethertype IPv4
>> (0x0800), length 34: 127.0.0.1 > 127.0.0.1:  ip-proto-0 0
>>
>> ..then for some reason Linux virtual-switch does not flood it to all
>> the ports(except the one where the frame came in from). Why is that
>> so? I would expect that switch handles multicast frames exactly like
>> broadcast frames.
>>
>>
>> thanks,
>> Martin
>
> Linux bridge does IGMP snooping (by default).
> Therefore you need an application that uses IGMP advertisements
> or manually disable this via sysfs.
>
