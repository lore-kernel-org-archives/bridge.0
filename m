Date: Sat, 4 Oct 2003 17:29:29 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Message-ID: <20031004152929.GA1174@man.beta.es>
References: <20030927202200.GA612@man.beta.es>
	<p05111b00bba2061773df@[10.96.96.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05111b00bba2061773df@[10.96.96.13]>
Subject: [Bridge] Re: bridge breaks loopback on 2.4.22
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hannes Schulz <schulz@schwaar.com>
Cc: linux-net@vger.kernel.org, bridge@osdl.org, marcelo.tosatti@cyclades.com, shemminger@osdl.org

> Perhaps you could try again with 2.4.23-pre[456].

I have tested with 2.4.23-pre6 and the problem seems fixed, in fact, I
tested 2.4.22 with 2.4.23-pre6 bridge, which means a minimal patch, an it
worked well also, thanks for your sugestion ;-)

So I believe that the problem was really in the bridge code but it seems
solved, now I only wish somebody could explain me how this bug in the bridge
code that was fixed in a little patch could be affecting the loopback :-?

Regards...
-- 
Manty/BestiaTester -> http://manty.net

PS: I'm replying Stephen in another mail with more data.
