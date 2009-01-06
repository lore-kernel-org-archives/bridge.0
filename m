Message-ID: <4963E41D.40904@navigue.com>
Date: Tue, 06 Jan 2009 18:07:09 -0500
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] new gretap, bridging and mtu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>

Greetings all,

I've setup a new gretap device as per Herbert Xu's new patches and it 
works as expected for smaller MTU.  I'm wondering if gretap tunnels 
handle fragmentation at all or if this might be a bridge related issue.

The same setup works quite well if I use vtun with a tap device however, 
so while this isn't entirely bridge-related, Maybe someone here might 
have experienced the same problem or might have insight as to what's 
causing the problem.  I imagine this might be more of an inherent 
limitation in gretap than a bug but as I am not to good with coding, I 
figured I'd ask smarter people ;)

                     network1        box1       network2       
box2        network1
801.2q (1504 bytes max) <-> (eth1-br0-gretap eth0) <-> (eth0 
gretap-br0-eth1) <-> 801.2q (1504 bytes max)

Jonathan


