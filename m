Return-Path: <andrew@lunn.ch>
Date: Tue, 29 Aug 2017 15:36:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170829133648.GF22093@lunn.ch>
References: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503980568-35240-1-git-send-email-roopa@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fdb add and delete
	tracepoints
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net, bridge@lists.linux-foundation.org

On Mon, Aug 28, 2017 at 09:22:48PM -0700, Roopa Prabhu wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> A few useful tracepoints to trace bridge forwarding
> database updates.

Hi Roopa

Once accepted, it would be nice to add mdb tracepoints as well. I
expect the implementation would be very similar.

       Andrew
