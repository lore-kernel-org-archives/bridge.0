Return-Path: <davem@davemloft.net>
Date: Fri, 10 May 2019 15:06:22 -0700 (PDT)
Message-Id: <20190510.150622.135840136910324302.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190510025212.10109-1-tobin@kernel.org>
References: <20190510025212.10109-1-tobin@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2] bridge: Fix error path for
	kobject_init_and_add()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: tobin@kernel.org
Cc: nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tyhicks@canonical.com, netdev@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>
Date: Fri, 10 May 2019 12:52:12 +1000

> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.  We currently
> set p to NULL so that kfree() may be called on it as a noop, the code is
> arguably clearer if we move the kfree() up closer to where it is
> called (instead of after goto jump).
> 
> Remove a goto label 'err1' and jump to call to kobject_put() in error
> return from kobject_init_and_add() fixing the memory leak.  Re-name goto
> label 'put_back' to 'err1' now that we don't use err1, following current
> nomenclature (err1, err2 ...).  Move call to kfree out of the error
> code at bottom of function up to closer to where memory was allocated.
> Add comment to clarify call to kfree().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> v1 was a part of a set.  I have dropped the other patch until I can work
> out a correct solution.

Applied and queued up for -stable, thanks.
