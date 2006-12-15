Date: Fri, 15 Dec 2006 10:31:30 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061215103130.237b58c6@freekitty>
In-Reply-To: <4582B8DF.2010702@cambridgebroadband.com>
References: <AA48EE0D609E8547912F0039B5E47BC261BE14@SHI-EXCHBE1.shipara.hcltech.com>
	<4582B8DF.2010702@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge_list orphans in linux-2.4
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: "Majjari Vikram(TLS-ESG), Bangalore" <Majjari.Vikram@hcl.in>, bridge@lists.osdl.org

On Fri, 15 Dec 2006 15:01:51 +0000
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> Hi Majjari,
> 
> We've solved the problem now.  It turned out that the bridge_list in the
> kernel was not being corrupted.   The problem was actually that
> "brctl show" was only returning the last 32 bridges created.  We upped
> this to 2048, which required a brctl change and also a kernel module change.
> 
> The patch is attached.
> 
> HTH,
> 
> Alex

Actually, I would prefer NOT to send this upstream for later 2.4 releases because
the 2.4 code is in long term stability mode, and support >32 bridges is an enhancement,
not a bug.
