Date: Thu, 4 May 2006 14:36:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Interface Statistics
Message-ID: <20060504143624.324274f6@localhost.localdomain>
In-Reply-To: <FFEPKIHJDEDDAAFOFDGFIEJGCBAA.PCDiem@FoxValley.net>
References: <FFEPKIHJDEDDAAFOFDGFIEJGCBAA.PCDiem@FoxValley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Paul C. Diem" <PCDiem@foxvalley.net>
Cc: bridge@lists.osdl.org

On Thu, 4 May 2006 16:16:33 -0500
"Paul C. Diem" <PCDiem@foxvalley.net> wrote:

> Is there anyway to get interface statistics such as multicast packets
> received/transmitted for the individual interfaces in a bridge or for the
> bridge as a whole?
> 
> Do the Receive/Transmit bytes/packets counters in /proc/net/dev reflect all
> packets received/transmitted (even those that were only bridged) or only
> those actually targeted to/irrigated from the server?
> 
> Thank you,
> 
> Paul C. Diem
> PCDiem@FoxValley.net
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

did you look at 'ip -s link'?
