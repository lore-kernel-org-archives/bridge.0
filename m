Return-Path: <michal.kepien@nask.pl>
Message-ID: <541FCC73.7030208@nask.pl>
Date: Mon, 22 Sep 2014 09:14:59 +0200
From: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal.kepien@nask.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Forwarding large fragmented IPv6 packets broken by
	nf_defrag_ipv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Greetings,

I have found an interoperability issue between two kernel modules:
bridge and nf_defrag_ipv6. After analyzing the issue, I decided to post
to this list first, assuming it would be more appropriate. However, if
this should be reported to another party, please let me know and I'll be
happy to follow your guidelines.

I believe kernel commit 6aafeef broke forwarding of large fragmented
IPv6 packets through a bridge when conntrack is enabled. That commit,
when nf_defrag_ipv6 is loaded, causes br_dev_queue_push_xmit() to
receive a "reassembled SKB" containing a list of fragments, instead of
fragment SKBs themselves. That in turn causes the is_skb_forwardable()
call to return false as it compares the reassembled packet size to the
destination MTU. If the former is larger, the packet is silently
dropped, even though it has been marked as ACCEPTed in ip6tables.

If the above description is unclear, please let me know and I'll
describe an example setup which would demonstrate the issue. I came
across this problem after putting a DNSSEC-enabled DNS server behind a
transparent firewall running Linux and querying for records which
generate large UDP responses.

--=20
Best regards,
Micha=C5=82 K=C4=99pie=C5=84
