Message-ID: <1196.80.133.183.165.1093361732.squirrel@80.133.183.165>
Date: Tue, 24 Aug 2004 17:35:32 +0200 (CEST)
Subject: Re: [Bridge] Encrypting Bridge?
From: "Rene Bartsch" <ML@Bartschnet.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Di, 24.08.2004, 01:45, Francois Ambrosini sagte:
> On Mon, 23 Aug 2004 10:31:26 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
>
> [snip]
>> The encrypting bridge isn't a bad idea, just not sure it is worth
maintaining
>> yet another VPN solution.
>>
>
> Greetings,
>
> IMHO, and in addition to what Rene Bartsch said, providing an encrypted
tunnel at layer 2 can be really useful when it comes to bandwidth and/or
latency matters.
> Moreover, paranoid network administrators will always be interested in
such a feature. It would be the closest solution to direct physical
encryption without having to buy any special hardware, and without the
overhead of a layer 3 tunnel (just like the encryption part of WPA is to
Wi-Fi).
>
> Alas, adding encryption to the brigde features is not enough: it should
scale well, meaning that a decent key management system would have to be
provided as well, in user space. To make things clear, I am only
speaking of managing the keys on the different nodes of the encrypted
switched network (no things like authentication, certificates, PKI and
alike). On the top of that, if direct interoperability with other OSes
was to be achieved with such a feature, one would have to provide
drivers for this to work.
>
> Isn't all this getting outside the limits of the bridge ? Maybe
encryption should be provided by a seperate piece of code that would
stand beetween the ethernet driver(s) and the bridge (or the IP stack) ?
I am no specialist of neither the bridging code nor the networking
implementation in the Linux kernel, so correct me if I'm going in the
wrong direction.
>

My idea is the following:

If you add an GRE-tunnel to the bridge, you have a OS interoperable and
protocol independent tunneling. That means we just need encryption which
could be done by a additional bridge-nf/netfilter target "enc" with the
options "cipher" and "key".

So, in case of an ebtables rule

ebtables [yourmatches, e.g. "-o gre0"] -t enc --cipher [cipher, e.g. AES]
--key [public key of remote host]

all traffic going to gre0 would pass the target enc which doesn't do
anything else than passing the data and keys to the kernel cipher [cipher]
(e.g. AES) encrypting the data.

And for data coming from the tunnel a rule like

ebtables [yourmatches, e.g. "-i gre0"] -t enc --cipher [cipher, e.g. AES]
--key [private key of local host]

would cause decryption.

And if the PadLock functions of the VIA Nehemia cores could be used, we'd
have powerful but cheap VPN routers.

Comments?

Rene



