Message-ID: <4A678123.1020006@free.fr>
Date: Wed, 22 Jul 2009 23:14:11 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4A6638A5.208@ipfire.org> <4A668C49.7080209@superduper.net>
	<4A66C14C.4090300@ipfire.org> <4A677703.4060507@free.fr>
	<4A677ACA.3060100@ipfire.org>
In-Reply-To: <4A677ACA.3060100@ipfire.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Michael Tremer <michael.tremer@ipfire.org>
Cc: bridge@lists.linux-foundation.org

Michael Tremer wrote:
> Oops, just sent the email when your one scrabbled to my inbox.
> 
> https://lists.linux-foundation.org/pipermail/bridge/2009-July/006626.html
> 
> I applied that ebtables rule to the chain but no packages got to the 
> vlan interface (eth0.30) anymore.
> 
> Michael

For as far as I remember, this hack works really well when eth0 and 
eth0.30 are not in the same bridge (br0/br1). Anyway, I cannot think of 
a good reason for it not to work in a single bridge.

Try and dig around with ebtable, using the logging feature. Im' pretty 
sure it works, but does not have a bridge available here to test.

I googled around to try and find the original web page where a learned 
this hack, but without any success. You can try, searching for 
ebtables+BROUTING+DROP+802_1Q+vlan-id and so on...

	Nicolas.
