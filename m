Return-Path: <andres.pozom@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=308+oX7Kj4z/PPvpMDZffCOllx5/CDGYxhDPCLBppps=;
	b=TvA46U4qH3CAzFZjR+V597l/tL53lpxJUMPtUhEDDsPnvHbFEhelpAyAzVMmMYOdlS
	q0SYQoufWSjynT/qmy7SwOReOQo3Zz+6zsbJLHF0OnkaSBMX1l8yPVPU4/nyuLiX4GQD
	iR7x5frOKiqJLYg/WjiwnYdXdAP0lPEgUPa/ZHA3P6yCAf8CDpWWscoB45Vpe93IBhER
	f8mOTMx4v3eXkX6hPAMfMd9yPBeJLcDYUIT3Oyp92snZ9lEMniciZxEF0ZvxswJWwgLp
	N2wqiIz8CVpn93ii5rFfldEBgMPJV71YXyw46+fV1pLf20BiW1KA3WMPWwECtxGClYX0
	q+Nw==
MIME-Version: 1.0
In-Reply-To: <20171012075834.78103e4d@xeon-e3>
References: <CAPfKRs4GmA4568nt4a2kaHkmm3WmMETL1sXcT8xyByCvVGgFkQ@mail.gmail.com>
	<20171012075834.78103e4d@xeon-e3>
From: =?UTF-8?Q?Andr=C3=A9s_Pozo_Mu=C3=B1oz?= <andres.pozom@gmail.com>
Date: Mon, 16 Oct 2017 12:39:21 +0200
Message-ID: <CAPfKRs77RnmPVNqs-C39ZooVjfctrGR-WTHrcHxXXFT0w8FU7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problem with syslog in bridge(?) with ethernet
 broadcast packets with QinQ
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

Hi Stephen,

thanks for your response.

I managed to move forward removing the bridge from my schema. I think
the problem has to deal with multicast IPv6 addresses with QinQ in a
bridge.

If I remove that bridge and put the traffic through a vlan type
subinterface in the physical interface, everything seems to work fine
(and the syslog entry, no longer appears...).

I'll try to follow your suggestion and get that trace....

Thanks!
Regards,
Andres


On Thu, Oct 12, 2017 at 4:58 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Mon, 18 Sep 2017 17:21:11 +0200
> Andr=C3=A9s Pozo Mu=C3=B1oz <andres.pozom@gmail.com> wrote:
>
>> Hi all,
>>
>> I'm facing some problem with ethernet multicast traffic and QinQ
>> (802.3q in both tags) in -apparently- a bridge in Ubuntu 16.04
>> (4.12.0-041200-generic).
>>
>> My set up is the following:
>> +-----------+
>> |     VM    |
>> +-----+-----+
>>       |
>>       | tag 55
>> +---------+------------+
>> |        OVS           |
>> +-----------+----------+
>>                 | veth3.9
>> veth3   +  |
>>      +--+
>>      | veth2
>> +-------+----------+
>> |       BRIDGE     |
>> +-------+----------+
>>      |
>>      |
>> +-------+----------+
>> |      ens11f1     |
>> +------------------+
>>
>>
>> I am setting the inner tag with OVS and the outer tag with a vlan type v=
eth.
>> The problem I have is that every packet sent from the VM to Ethernet
>> broadcast addresses (33:33:xx:xx:xx:xx) generates a "IPv6 header not
>> found" entry in syslog.
>>
>> If I generate a 'ens11f1.9' interface and remove the BRIDGE, the log
>> entry dissapears.
>>
>> Some questions:
>> * Is there any problem with these packets (ethernet multicast with
>> QinQ) in bridges?
>> * Is there any configuration I should change for the problem to dissapea=
r?
>>
>> Thanks in advance for your help! Any hint about what could be
>> generating those logs is appreciated.
>>
>> Regards,
>> Andr=C3=A9s Pozo
>
> Where is the log message coming from? Could you change the printk into
> a WARN_ON_ONCE and get backtrace? My guess is the firewall code doesn't
> understand the additional tag.
