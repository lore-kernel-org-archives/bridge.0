Return-Path: <davem@davemloft.net>
Date: Tue, 29 Aug 2017 14:49:59 -0700 (PDT)
Message-Id: <20170829.144959.233090804778101017.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1504037817-38107-1-git-send-email-roopa@cumulusnetworks.com>
References: <1504037817-38107-1-git-send-email-roopa@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3] bridge: fdb add and delete
	tracepoints
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, f.fainelli@gmail.com, bridge@lists.linux-foundation.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue, 29 Aug 2017 13:16:57 -0700

> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> A few useful tracepoints to trace bridge forwarding
> database updates.
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> ---
> v2: address comments from florian
> v3: remove stray character '=' in print (pointed out by florian)

Applied, thanks.
