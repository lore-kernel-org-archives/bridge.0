From: Tristan DEFERT <tristan.d@alphamosa.fr>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:11:01 +0200
Message-Id: <1151417461.14087.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge+filter+failover+rules&state sync+traffic shaping
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

hi list!
i'm trying to find a convenient way to build a redundant filtering
bridge under linux

i looked at carp project, but carp doesn't support bridge

now i thing the most appropriate way is using stp or rstp
it seems that 2.6 kernel supports stp but what about rstp?

I read some docs about stp, but they are rather outdated (2001 and
kernel 2.2)

there are several problems indeed: 
* rstp support
* fw state sync
* fw rules sync

did some of you resolve these problems?

any help appreciated, i'm rather confused between rstp, stp, ct_sync,
conntrackd ...

ps: next step will be trafic shaping / load balancing implementation
within this setup, again, any help appreciated!

