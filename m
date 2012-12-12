Return-Path: <shemminger@vyatta.com>
Date: Wed, 12 Dec 2012 10:41:38 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20121212104138.2a927498@nehalam.linuxnetplumber.net>
In-Reply-To: <1355300590-2390-4-git-send-email-amwang@redhat.com>
References: <1355300590-2390-1-git-send-email-amwang@redhat.com>
	<1355300590-2390-4-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] iproute2: add support to monitor mdb
	entries too
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Wed, 12 Dec 2012 16:23:10 +0800
Cong Wang <amwang@redhat.com> wrote:

> From: Cong Wang <amwang@redhat.com>
> 
> This patch implements `bridge monitor mdb`.
> 
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: Thomas Graf <tgraf@suug.ch>
> Signed-off-by: Cong Wang <amwang@redhat.com>
> 

Accepted for 3.8 since Dave accepted the kernel parts. Thanks
