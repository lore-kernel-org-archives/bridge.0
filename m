Date: Wed, 14 Mar 2007 10:58:28 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070314105828.6191fcaf@freekitty>
In-Reply-To: <BAY137-F24034DC7B4E8519C2B0A80FD730@phx.gbl>
References: <BAY137-F24034DC7B4E8519C2B0A80FD730@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] tracking packets through bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jie Chen <cj70286@hotmail.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, bridge@lists.osdl.org

On Wed, 14 Mar 2007 17:50:50 +0000
"Jie Chen" <cj70286@hotmail.com> wrote:

> Hi,
> 
> 
> 
> I got a question about tracking the packets on bridge. I have a few linux 
> boxes set up with bridge and STP running, which has two interfaces enslaved 
> to the bridge, if I want to send packets from one to another, how do I track 
> which interface I'm using to send packets?
> 
> Thanks,
> 
> Jie

Look at the forwarding table:
	brctl showmacs br0
