Date: Wed, 7 Jan 2009 12:04:43 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20090107010443.GA3284@gondor.apana.org.au>
References: <4963E41D.40904@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4963E41D.40904@navigue.com>
Subject: Re: [Bridge] new gretap, bridging and mtu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Jan 06, 2009 at 06:07:09PM -0500, Jonathan Thibault wrote:
>
>                     network1        box1       network2       box2        
> network1
> 801.2q (1504 bytes max) <-> (eth1-br0-gretap eth0) <-> (eth0  
> gretap-br0-eth1) <-> 801.2q (1504 bytes max)

gretap should handle fragmentation in the same way as IP over GRE.
The default for both is to disable fragmentation.  You need to
configure your tunnel to enable fragmentation by disabling PMTU
if you want to use a larger MTU.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
