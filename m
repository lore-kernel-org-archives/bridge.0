MIME-Version: 1.0
Date: Tue, 12 Jan 2010 20:44:04 +0100
Message-ID: <8cad0aa1001121144p315dd187ra92d99d2bb961642@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Re :Re:  Bridging LACP (802.3ad) frames not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>, Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

Hi, me again...

>> eth0 \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ eth2
>>
>> =A0 =A0 =A0bond0 ----- br0 ---- bond1
>>
>> eth1 / =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ eth3
>>
>

I only have two physical ports (eth0 and eth1).
Do you think, with your solution, that I should bond eth0 with a
virtual network interface ; bonding eth1 with another virtual
interface.
Then, I have a bridge between bond0 and bond1 ?

I cannot have 4 physical interfaces.

Thanks in advance !
Regards,
JM
