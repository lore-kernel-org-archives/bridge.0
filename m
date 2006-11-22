Date: Wed, 22 Nov 2006 09:57:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061122095720.531d6a99@freekitty>
In-Reply-To: <BAY128-F390D1C30D9837B677EDF7CD9E30@phx.gbl>
References: <BAY128-F390D1C30D9837B677EDF7CD9E30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] how to configure RSTP (802.1w) on SUSE 10 (kernel
 2.6.13-15)
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: nas was <whaque09@hotmail.com>
Cc: bridge@lists.osdl.org

On Wed, 22 Nov 2006 15:18:05 +0100
"nas was" <whaque09@hotmail.com> wrote:

> Hi there,
> 
> I am a student and working on a project where i need to configure RSTP 
> (802.1w) on SUSE 10  kernel 2.6 so that i can able to analyse efficient link 
> fail-over time, i have found STP configuration at  ( 
> http://linux-net.osdl.org/index.php/Bridge )  but coulnt find partticular 
> RSTP configuration.
> i would appriciate if you could help me in this regard.
> 
> cheers,
> was
> 
>
RSTP is not implemented in the current bridge code, there have been some
attempts, but no complete mainstream implementation yet.


-- 
Stephen Hemminger <shemminger@osdl.org>
