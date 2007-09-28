Message-ID: <46FCBC98.6030507@sysnetsistemi.it>
Date: Fri, 28 Sep 2007 10:34:32 +0200
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
MIME-Version: 1.0
Subject: Re: [Bridge] Flushing MAC-tables(?)
References: <46FCB3F4.4080802@googlemail.com>
In-Reply-To: <46FCB3F4.4080802@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dennis Borgmann <dennis.borgmann@googlemail.com>
Cc: bridge@lists.linux-foundation.org

Dennis Borgmann wrote:
> So at a certain point of time, there seems to be a flushing of some
> bridge-tables, but I don't know, how I could influence this behaviour.
> Is this "flushing" somehow to be done manually? Or is there a timer,
> which sets this behaviour?
in recent kernel (not in 2.4, and maybe only in recent 2.6) you can 
flush the FDB using sysfs:
/sys/class/net/%s/bridge/flush (whole bridge)
/sys/class/net/%s/brif/%s/flush (single interface)

If you want you can lower the ageing timer from the default 300sec using 
brcl setageing

Maybe you can just force your phone to register more frequently so the 
bridge will just learn the new port when you move.

Francesco
