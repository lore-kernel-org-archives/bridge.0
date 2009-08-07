From: "Paul Congdon \(UC Davis\)" <ptcongdon@ucdavis.edu>
References: <0199E0D51A61344794750DC57738F58E6D6A6CD7F6@GVW1118EXC.americas.hpqcorp.net>	<004f01ca1792$b24a7a90$16df6fb0$@edu>
	<20090807123554.7c2bc27c@nehalam>
In-Reply-To: <20090807123554.7c2bc27c@nehalam>
Date: Fri, 7 Aug 2009 12:47:38 -0700
Message-ID: <005601ca1797$ef5dc180$ce194480$@edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@vyatta.com>
Cc: herbert@gondor.apana.org.au, 'Arnd Bergmann' <arnd@arndb.de>, mst@redhat.com, "'Fischer, Anna'" <anna.fischer@hp.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ogerlitz@voltaire.com, netdev@vger.kernel.org, evb@yahoogroups.com, davem@davemloft.net

> 
> I do have to raise the point that Linux is perfectly capable of keeping
> up without
> the need of an external switch.  Whether you want policy external or
> internal is
> a architecture decision that should not be driven by mis-information
> about performance.

No argument here.  I agree that you can do a lot in Linux.  It is, as you
say, an architecture decision, that can be enabled with this addition mode
of operation.  Without the mode of forcing things external, however, you
would always need to put this function internal or play games with VLANs
overlapping to get traffic to forward the way you want it.

Paul

