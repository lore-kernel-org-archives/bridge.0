Message-ID: <18562.193.196.136.17.1177236931.squirrel@sleon.dyndns.org>
In-Reply-To: <462A9C3F.1010600@schaus.ca>
References: <60846.193.196.136.17.1177202163.squirrel@sleon.dyndns.org>
	<462A9C3F.1010600@schaus.ca>
Date: Sun, 22 Apr 2007 10:15:31 -0000 (UTC)
Subject: Re: [Bridge] linux bridge does not bridge bpdu packets
From: "Roman Glebov" <sleon@sleon.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: sleon@sleon.dyndns.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cameron Schaus <cam@schaus.ca>
Cc: bridge@lists.linux-foundation.org

Hallo,

Thank you very much for that suggestion.

I need that it forwards that functionality.
Because it should be completely transparent.

I think i will patch the kernel


With regards,

Roman Glebov

> Roman Glebov wrote:
>
>>The problem is : all stp packets which come to one side of the Bridge are
>>not forwarded to the other side. Which distrubs stp when this device is
>>put inbetween of two stp capable devices.
>>It forwards all traffik through it.
>>Normal udp/tcp traffik is forwarded.
>>
>>I switched stp on it "off" so it does not participate in Spanning tree
>>communications.
>>
>>
> I don't think you are doing anything wrong.  I asked this question a
> while back, and was told that this behaviour conforms to the 802 spec.
> Please see:
> https://lists.linux-foundation.org/pipermail/bridge/2006-December/005169.html
>
> Cam
>
>

