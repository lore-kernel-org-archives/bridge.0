Message-ID: <4B323EE8.6000206@pandora.be>
Date: Wed, 23 Dec 2009 17:01:44 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <00163600ce448e8674047b65d7bf@google.com>
In-Reply-To: <00163600ce448e8674047b65d7bf@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Re :Re:  ebtables, PF_PACKET and other stuff
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jhautbois@gmail.com
Cc: bridge@lists.linux-foundation.org

jhautbois@gmail.com schreef:
>> Send those packets to the ULOG target when dropping them.
>
>
>
>>  From the ebtables manpage:
>
>
>
>> ulog
>
>
>
>> The ulog watcher passes the packet to a userspace logging daemon using
>
>> netlink multicast sockets. This differs from the log watcher in the
>
>> sense that the complete packet is sent to userspace instead of a
>
>> descriptive text and that netlink multicast sockets are used instead
>
>> of the syslog. This watcher enables parsing of packets with userspace
>
>> programs
>
>> (snip)
>
> Mmh, ok, but from the userspace point of view, how can I get them ? A
> SOCK_RAW ?
>
See http://ebtables.sourceforge.net/examples/basic.html#ex_ulog

cheers,
Bart

-- 
Bart De Schuymer
www.artinalgorithms.be

