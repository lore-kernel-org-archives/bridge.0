Date: Wed, 2 Jun 2010 19:42:13 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100602194213.4147e2ce@nehalam>
In-Reply-To: <4C06FE06.8040502@cfl.rr.com>
References: <4C06FE06.8040502@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Spanning tree mapping utility
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Bridge@lists.linux-foundation.org

On Wed, 02 Jun 2010 20:57:42 -0400
Phillip Susi <psusi@cfl.rr.com> wrote:

> I actually don't want to enable kernel ethernet bridging, but I do want 
> to map the existing bridges on the network.  Does anyone know of a tool 
> that can monitor the BPDUs to do that?
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

Open up an AF_PACKET or AF_LLC socket and receive them

-- 
