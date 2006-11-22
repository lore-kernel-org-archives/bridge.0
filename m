Message-ID: <bdfc5d6e0611221020w53bc331h314a172f99e103bb@mail.gmail.com>
Date: Wed, 22 Nov 2006 13:20:10 -0500
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
In-Reply-To: <BAY128-F390D1C30D9837B677EDF7CD9E30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY128-F390D1C30D9837B677EDF7CD9E30@phx.gbl>
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

On 11/22/06, nas was <whaque09@hotmail.com> wrote:
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

I'm not sure STP is exactly what you want to use to solve this problem
and since RSTP is not available yet it might not be the best idea.

Have you considered using bonding for dealing with redundancy/high-availability?
