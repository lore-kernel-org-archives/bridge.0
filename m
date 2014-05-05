Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=1hZjfLRPcX50lcrhEBpCS8bQ8xWo6q60z25GFAMe740=;
	b=vPE1npRf3nY0kBcRVEFMTIbrZPBEedt4y+zFqpm/W8khI2SB7rthb491TrQynhaPAP
	G8i7lE5H+Rm7DV/LBhQIgCumu98lLHn2KKArNxIn2yoEPckFpuKYYPk54o6o7H6DSImN
	H4XL6bU6K18JP+nPcku348YGhiqf6cjDjEL0ZXgI7KIWpMCb497zF/Yq/ACIWSsXTa6R
	QHHwQQAX85nUFMfbbHiMD8WIeKsreK6RUHezl3suwq+OV61CgIpYPeG39YwQ5NZUvLR3
	Emj+Wr0qDpTvrgl5vG0jmmEKR29O2RtEpQupdgatbN3JcS16eBkxOytRCTZ/nUz9OOhJ
	7w8w==
MIME-Version: 1.0
In-Reply-To: <20140504155331.13862a85@nehalam.linuxnetplumber.net>
References: <1399238974-6210-1-git-send-email-jmaxwell@redhat.com>
	<20140504155331.13862a85@nehalam.linuxnetplumber.net>
Message-ID: <CAADnVQL3OZwZ0q_utwE_JhYYGbKPHwwqwHsBZ9g+0XAS__BpWQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net] bridge: Add port flap detection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 05 May 2014 04:06:38 -0000
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: vyasevic@redhat.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, pirko@redhat.com, Jon Maxwell <jmaxwell37@gmail.com>, "David S. Miller" <davem@davemloft.net>

On Sun, May 4, 2014 at 3:53 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Mon,  5 May 2014 07:29:34 +1000
> Jon Maxwell <jmaxwell37@gmail.com> wrote:
>
>> There has been a number incidents recently where customers running KVM h=
ave reported that VM hosts on different Hypervisors are unreachable. Based =
on pcap traces we found that the bridge was broadcasting the ARP request ou=
t onto the network. However some NICs have an inbuilt switch which on occas=
ions were broadcasting the VMs ARP request back through the physical NIC on=
 the Hypervisor. This resulted in the bridge flapping ports and incorrectly=
 learning that the VMs mac address was external. As a result the ARP reply =
was directed back onto the external network and VM never updated it's ARP c=
ache. This patch will detect port flapping and log a message so that this c=
ondition can be detected earlier.
>>
>> Signed-off-by: Jon Maxwell <jmaxwell@redhat.com>
>> ---
>>  net/bridge/br_fdb.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index 9203d5a..c08607b 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -507,6 +507,13 @@ void br_fdb_update(struct net_bridge *br, struct ne=
t_bridge_port *source,
>>                                       source->dev->name);
>>               } else {
>>                       /* fastpath: update of existing entry */
>> +                     if (source->port_no !=3D fdb->dst->port_no &&
>> +                             net_ratelimit())
>> +                             br_warn(br, "Port flapping detected source=
 entry dev =3D %s mac =3D %pM, port_no =3D %d\n existing entry dev =3D %s m=
ac =3D %pM, port_no =3D %d\n",
>> +                                     source->dev->name,
>> +                                     addr, source->port_no,
>> +                                     fdb->dst->dev->name, addr,
>> +                                     fdb->dst->port_no);
>>                       fdb->dst =3D source;
>>                       fdb->updated =3D jiffies;
>>                       if (unlikely(added_by_user))
>
> Ok, but please shorten the message to a single line without excess wordag=
e.
> Plus flapping to mean means link going up and down. Maybe use same messag=
e
> as BSD?

Isn't this normal mac move? Any message will be confusing.
VMs can spoof their src macs and trigger this warning.
I don't think it's worth adding it just to debug the learning on the
external interface.
