Date: Tue, 24 Aug 2004 01:45:02 +0200
From: Francois Ambrosini <fambrosini@nerim.fr>
Subject: Re: [Bridge] Encrypting Bridge?
Message-Id: <20040824014502.066779f0.fambrosini@nerim.fr>
In-Reply-To: <20040823103126.72631cf6@dell_ss3.pdx.osdl.net>
References: <3739.80.133.187.52.1092948476.squirrel@80.133.187.52>
	<20040823103126.72631cf6@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: ML@bartschnet.de, bridge@lists.osdl.org

On Mon, 23 Aug 2004 10:31:26 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

[snip]
> The encrypting bridge isn't a bad idea, just not sure it is worth maintaining
> yet another VPN solution.
> 

Greetings,

IMHO, and in addition to what Rene Bartsch said, providing an encrypted tunnel at layer 2 can be really useful when it comes to bandwidth and/or latency matters.
Moreover, paranoid network administrators will always be interested in such a feature. It would be the closest solution to direct physical encryption without having to buy any special hardware, and without the overhead of a layer 3 tunnel (just like the encryption part of WPA is to Wi-Fi).

Alas, adding encryption to the brigde features is not enough: it should scale well, meaning that a decent key management system would have to be provided as well, in user space. To make things clear, I am only speaking of managing the keys on the different nodes of the encrypted switched network (no things like authentication, certificates, PKI and alike). On the top of that, if direct interoperability with other OSes was to be achieved with such a feature, one would have to provide drivers for this to work.

Isn't all this getting outside the limits of the bridge ? Maybe encryption should be provided by a seperate piece of code that would stand beetween the ethernet driver(s) and the bridge (or the IP stack) ? I am no specialist of neither the bridging code nor the networking implementation in the Linux kernel, so correct me if I'm going in the wrong direction.

Regards,

Francois
